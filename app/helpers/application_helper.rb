module ApplicationHelper
	def select_tag_for_categories(selected="")
		select_tag "category", options_from_collection_for_select(Category.all, "id", "name", {:prompt => "None"})

	end
	
	def select_tag_for_languages(selected="")
		select_tag "language", options_from_collection_for_select(Language.all, "id", "name"), {:prompt => "None"}
	end	
end
