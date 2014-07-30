module CategoryHelper

	def lookup_wikipedia(category)
		url = ""
		category.contents.each do |content|
			url = content.url if content.source == "wikipedia"
		end
		url
	end


end
