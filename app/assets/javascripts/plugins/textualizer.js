/**
Textualizer v2.3.1
    
Dual licensed under the MIT or GPL Version 2 licenses.

Copyright (c) 2011 Kirollos Risk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
(function ($) {
    $(function () {

        var COMMON_CHARACTER_ARRANGE_DELAY = 1000,
            REMAINING_CHARACTERS_DELAY = 500,
            EFFECT_DURATION = 2000,
            REMAINING_CHARACTERS_APPEARANCE_MAX_DELAY = 2000,
            REMOVE_CHARACTERS_MAX_DELAY = 2000;

        /**
         * Overloads:
         * 1. textualizer(data, options)
         * 2. textualizer(data)
         * 3. textualizer(options)
         *
         * @param data: Array of texts to transition
         * @param options:
         * <effect> - name of the effect to apply: random, fadeIn, slideLeft, slideTop.
         * <duration> - Time (ms) to keep a blurb on the screen before transitioning to the next one
         * <rearrangeDuration> - Time (ms) for characters to arrange into position
         */
        $.fn.textualizer = function (data, options) {
            var args = arguments;

            // Creates a textualizer instance (if it doesn't already exist)
            var txtlzr = (function (ele) {
                var obj = ele.data('textualizer');
                if (!obj) {
                    var data = [],
                        options;

                    if (args.length === 1 && args[0] instanceof Array) {
                        data = args[0];
                    } else if (args.length === 1 && typeof args[0] === 'object') {
                        options = args[0];
                    } else if (args.length === 2) {
                        data = args[0];
                        options = args[1];
                    }

                    if (data.length === 0) {
                        ele.find('p').each(function () {
                            data.push($(this).text());
                        });
                    }

                    // Clear the contents in the container, since this is where the blurbs will go
                    ele.html("");

                    // Create a textualizer instance, and store in the HTML node's metadata
                    obj = new Textualizer(ele, data, $.extend({}, $.fn.textualizer.defaults, options));
                    ele.data('textualizer', obj);
                }
                return obj;
            })(this);

            if (typeof args[0] === 'string' && txtlzr[args[0]]) {
                txtlzr[args[0]].apply(txtlzr, Array.prototype.slice.call(args, 1));
            }

            return this;
        }

        $.fn.textualizer.defaults = {
            effect: 'random',
            duration: 2000,
            rearrangeDuration: 1000
        };

        // Effects for characters transition+animation. Customize as you please
        $.fn.textualizer.effects = {
            none: function (item) {
                this.container.append(item.domNode.show());
            },
            fadeIn: function (item, dfd) {
                this.container.append(item.domNode.fadeIn(EFFECT_DURATION, dfd.resolve));

                return dfd.promise();
            },
            slideLeft: function (item, dfd) {
                item.domNode.appendTo(this.container).css({
                    'left': -1000
                }).show().animate({
                    'left': item.pos.left
                }, EFFECT_DURATION, dfd.resolve);

                return dfd.promise();
            },
            slideTop: function (item, dfd) {
                item.domNode.appendTo(this.container).css({
                    'top': -1000
                }).show().animate({
                    'top': item.pos.top
                }, EFFECT_DURATION, dfd.resolve);

                return dfd.promise();
            }
        }

        // Copy all effects into an array ==> Makes randomization easy
        var effectList = [];
        $.each($.fn.textualizer.effects, function (key, value) {
            if (key !== 'none') {
                effectList.push(key);
            }
        });

        var Blurb = function () {
                this.str = ''; // The text string
                this.chars = []; // Array of ch objects
            }
        Blurb.prototype = {
            // Loops through <chars>, and find the first ch whose character matches c, and hasn't been already used.
            use: function (c) {
                for (var i = 0, len = this.chars.length; i < len; i++) {
                    var l = this.chars[i];
                    if (l.ch === c && !l.used) {
                        l.used = true; // Mark as used.  
                        return l;
                    }
                }
                return null;
            },
            // Resets ever character in <chars>
            reset: function () {
                $.each(this.chars, function (index, ch) {
                    ch.inserted = false;
                    ch.used = false;
                });
            }
        }

        var Character = function () {
                this.ch = null; // A character
                this.domNode = null; // The span element that wraps around the character
                this.pos = null; // The domNode position
                this.used = false;
                this.inserted = false;
                this.visited = false;
            }

            // Gets all the styles (including the computed) from a given DOM element
        function getStyle(dom) {

            var style, styleList = {};

            if (window.getComputedStyle) {

                var camelize = function (a, b) {
                        return b.toUpperCase();
                    }

                style = window.getComputedStyle(dom, null);

                if (style.length) {
                    for (var i = 0, len = style.length; i < len; i++) {
                        var prop = style[i],
                            camel = prop.replace(/\-([a-z])/, camelize),
                            val = style.getPropertyValue(prop);

                        styleList[camel] = val;
                    }
                } else {
                    for (var prop in style) {
                        if (typeof style[prop] !== 'function' && prop !== 'length') {
                            styleList[prop] = style[prop];
                        }
                    }
                }
            } else {
                style = dom.currentStyle || dom.style;

                for (var prop in style) {
                    styleList[prop] = style[prop];
                }
            }

            return styleList;
        }

        var Textualizer = function (element, data, options) {
                this.options = options;

                // Clone the target element, and remove the id attribute (if it has one)
                // Why remove the id? Cuz when we clone an element, the id is also copied.  That's a very bad thing,
                var clone = element.clone().removeAttr('id').appendTo(document.body);

                // Copy all the styles.  This is especially necessary if the clone was being styled by id in a stylesheet)
                clone.css(getStyle(element[0]));

                // Note that the clone needs to be visible so we can do the proper calculation
                // of the position of every character.  Ergo, move the clone outside of the window's 
                // visible area.
                clone.css({
                    position: 'absolute',
                    top: '-1000px'
                });

                this.phantomContainer = $('<div />').css({
                    'position': 'relative',
                    'visibility': 'hidden'
                }).appendTo(clone);

                // Make sure any animating character disappear when outside the boundaries of 
                // the element
                element.css('overflow', 'hidden');

                this.elementHeight = element.height();

                // Contains transitioning text           
                this.container = $('<div />').css('position', 'relative').appendTo(element);

                // Holds the previous blurb
                this._previous = null;

                this._position = {}
                this._position.bottom = element.height();

                this.blurbs = [];

                if (data && data instanceof Array) {
                    this.data(data);
                }
            }

        Textualizer.prototype = {
            data: function (d) {
                this.stop();
                this.list = d;
                this.blurbs = [];
            },
            start: function () {
                // If there are no items, then simply exit
                if (!this.list || this.list.length === 0) {
                    return;
                }

                var self = this,
                    index = this._index || 0;

                this._pause = false;

                // Begin transitioning through the items
                function rotate(i) {
                    if (self._pause) {
                        return;
                    }
                    // <_rotate> returns a promise, which completes when a blurb has finished animating.  When that 
                    // promise is fulfilled, transition to the next blurb.
                    self._rotate(i).done(function () {
                        setTimeout(function () {
                            // If we've reached the last blurb, reset the position of every character in every blurb
                            if (i === self.list.length - 1) {
                                i = -1;
                                $.each(self.blurbs, function (j, item) {
                                    item.reset();
                                });
                            }
                            i++;
                            self._index = i;
                            rotate(i); // rotate the next blurb
                        }, self.options.duration);
                    });
                }

                // Begin iterating through the list of blurbs to display
                rotate(index);
            },
            stop: function () {
                this.pause();
                this._previous = null;
                this._index = 0;
                this.container.empty();
                this.phantomContainer.empty();
            },
            pause: function () {
                this._pause = true;
            },
            _rotate: function (index) {
                var dfd = $.Deferred(),
                    current = this.blurbs[index];

                // If this is the first time the blurb is encountered, each character in the blurb is wrapped in
                // a span and appended to an invisible container, thus we're able to calculate the character's position
                if (!current) {
                    var phantomBlurbs = [],
                        i, len, ch, c;

                    current = new Blurb();
                    current.str = this.list[index];
                    this.blurbs.push(current);

                    // Add all chars first to the phantom container. Let the browser deal with the formatting.
                    for (i = 0, len = current.str.length; i < len; i++) {
                        ch = current.str.charAt(i);

                        if (ch === '') {
                            this.phantomContainer.append(' ');
                        } else {
                            c = new Character();
                            c.ch = ch;
                            c.domNode = $('<span/>').text(ch);

                            this.phantomContainer.append(c.domNode);
                            phantomBlurbs.push(c);
                        }
                    }

                    // If options.centered is true, then we need to center the text.
                    // This cannot be done solely with CSS, because of the absolutely positioned characters
                    // within a relative container.  Ergo, to achieve a vertically-aligned look, do 
                    // the following simple math:
                    var height = this.options.centered ? (this.elementHeight - this.phantomContainer.height()) / 2 : 0;

                    // Figure out the positioning, and clone the DOM domNode
                    $.each(phantomBlurbs, function (index, c) {
                        c.pos = c.domNode.position();
                        c.domNode = c.domNode.clone();

                        c.pos.top += height;

                        c.domNode.css({
                            'left': c.pos.left,
                            'top': c.pos.top,
                            'position': 'absolute'
                        });
                        current.chars.push(c);
                    });

                    this.phantomContainer.html('');
                }

                if (this._previous) {
                    // For every character in the previous text, check if it exists in the current text.
                    // YES ==> keep the character in the DOM
                    // NO ==> remove the character from the DOM
                    var self = this,
                        keepList = [],
                        removeList = [],
                        dfds = [];

                    var randomHideEffect = getRandomHideEffect.call(this);

                    $.each(this._previous.chars, function (index, prevC) {
                        var currC = current.use(prevC.ch);

                        if (currC) {
                            currC.domNode = prevC.domNode; // use the previous DOM domNode
                            currC.inserted = true;

                            keepList.push(currC);
                        } else {
                            var d = $.Deferred();
                            removeList.push(d);

                            randomHideEffect(prevC.domNode.delay(Math.random() * REMOVE_CHARACTERS_MAX_DELAY)).done(function () {
                                prevC.domNode.remove();
                                d.resolve();
                            });
                        }
                    });

                    // When all characters that aren't common to the blurbs have been removed...
                    $.when.apply(null, removeList).done(function () {
                        // Move charactes that are common to their new position
                        setTimeout(function () {
                            $.each(keepList, function (index, item) {
                                var d = $.Deferred();
                                item.domNode.animate({
                                    'left': item.pos.left,
                                    'top': item.pos.top
                                }, self.options.rearrangeDuration, d.resolve);
                                dfds.push(d.promise());
                            });
                            // When all the characters have moved to their new position, show the remaining characters
                            $.when.apply(null, dfds).done(function () {
                                setTimeout(function () {
                                    showCharacters.call(self, current).done(function () {
                                        dfd.resolve();
                                    });
                                }, REMAINING_CHARACTERS_DELAY);
                            });
                        }, COMMON_CHARACTER_ARRANGE_DELAY);
                    });

                } else {
                    showCharacters.call(this, current).done(function () {
                        dfd.resolve();
                    });
                }
                this._previous = current;

                return dfd.promise();
            },
            destroy: function () {
                this.container.parent().removeData('textualizer').end().remove();
                this.phantomContainer.remove();
            }
        }

        function getRandomHideEffect() {
            var self = this;
            var eff = [

            function (target) {
                var d = $.Deferred();
                target.animate({
                    top: self._position.bottom,
                    opacity: 'hide'
                }, d.resolve);
                return d.promise();
            }, function (target) {
                var d = $.Deferred();
                target.fadeOut(1000, d.resolve);
                return d.promise();
            }];

            return eff[Math.floor(Math.random() * eff.length)];
        }

        function showCharacters(item) {
            var self = this,
                effect = this.options.effect === 'random' ? $.fn.textualizer.effects[effectList[Math.floor(Math.random() * effectList.length)]] : $.fn.textualizer.effects[this.options.effect],
                finalDfd = $.Deferred(),
                animationDfdList = [];

            // Iterate through all ch objects
            $.each(item.chars, function (index, ch) {
                // If the character has not been already inserted, animate it, with a delay
                if (!ch.inserted) {
                    ch.domNode.css({
                        'left': ch.pos.left,
                        'top': ch.pos.top
                    });

                    var animationDfd = $.Deferred();

                    setTimeout(function () {
                        effect.call(self, ch, animationDfd);
                    }, Math.random() * REMAINING_CHARACTERS_APPEARANCE_MAX_DELAY);

                    animationDfdList.push(animationDfd);
                }
            });

            // When all characters have finished moving to their position, resolve the final promise
            $.when.apply(null, animationDfdList).done(function () {
                finalDfd.resolve();
            });

            return finalDfd.promise();
        }
    });
})(jQuery);