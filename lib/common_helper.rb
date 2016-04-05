module CommonHelper
	require 'csv'   
	PRIORITY = [['Books', '1'],['videos', '2'],['WebLinks','3']]
	SORTING = [['Highly Rated','1'],['Most viewed','2']]
	class << self

		def update_db
			csv_text = File.read('tolc.csv')
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				Book.create(title: row[1],description: row[0],url: row[2],image_url: row[5], category: row[3], subcategory: row[4])
			end
		end

		def update_books_rating
			Book.all.each do |book|
				begin
					book.rating = book.rating1 + book.rating2 + book.rating3 + book.rating4 + book.rating5
					book.save
				rescue
					book.rating = 0
					book.rating1 = 0
					book.rating2 = 0
					book.rating3 = 0
					book.rating4 = 0
					book.rating5 = 0
					book.save
				end
			end
		end
	end
end