(function() {
	/* Cuepoint Coffee. A simple library for HTML5 Video Subtitles and Cuepoints */
	
	/**
	 * @class Utils 
	*/
	
	var Cuepoint, Utils, utils;
	Utils = (function() {
		function Utils() {}
		Utils.prototype.log = function(args) {
			this.args = args;
			if (window.console) {
				return console.log(Array.prototype.slice.call(this, arguments));
			}
		};
		return Utils;
	})();
	
	/**
	 * @class Cuepoint
	 */
	
	Cuepoint = (function() {
		function Cuepoint() {
			this.nativeKeys = Object.keys;
		}
		Cuepoint.prototype.init = function(slides) {
			var key, value, _results;
			this.slides = slides;
			this.subtitles = document.getElementById("subtitles");
			this.video = document.getElementById("video");
			_results = [];
			for (key in slides) {
				value = slides[key];
				this.addSlide(key, value);
				_results.push(this.events.call);
			}
			return _results;
		};
		Cuepoint.prototype.events = function() {};
		Cuepoint.prototype.currentTime = function() {
			return this.video.currentTime;
		};
		Cuepoint.prototype.update = function(html) {
			this.html = html;
			return this.subtitles.innerHTML = this.html;
		};
		Cuepoint.prototype.setTime = function(time) {
			this.time = time;
			this.video.currentTime = time;
			return this.video.play();
		};
		Cuepoint.prototype.addSlide = function(time, html) {
			var self;
			this.time = time;
			this.html = html;
			self = this;
			return this.video.addEventListener("timeupdate", function() {
				if (this.currentTime >= time && this.currentTime <= time + 0.3) {
					return self.update(html);
				}
			},
			false);
		};
		Cuepoint.prototype.play = function() {
			return this.video.play();
		};
		Cuepoint.prototype.pause = function() {
			if (!this.video.paused) {
				return this.video.pause();
			}
		};
		return Cuepoint;
	})();
	utils = new Utils;
	window.cuepoint = new Cuepoint;
}).call(this);
$(document).ready(function(){
	//Slides object with a time (integer) and a html string
	/*var slides = {
	0: "This is the first subtitle. You can put html in here if you like",
	4: "A fluffy thing eating some grass.",
	12: "Oh look it's a castle on a hill. Nice",
	23: "Some horses",
	34: "Wow look at those woolly sheep eating grass.",
	40: "For more information on this plugin visit github/owainlewis or email owain@owainlewis.com",
	50: "Cuepoint.js is an open source plugin for adding subtitles and cue-points to your HTML5 video"
	}
	//Start cuepoint and pass in our the subtitles we want
	cuepoint.init(slides);

	//You can set your own skip to links by using the cuepoint.setTime(seconds) function
	$('#1').click(function(){ cuepoint.setTime(40)});
	$('#2').click(function(){ cuepoint.setTime(80)});
	$('#3').click(function(){ cuepoint.setTime(60)});
	$('#4').click(function(){ cuepoint.setTime(60)});
	console.log("hello");*/
});