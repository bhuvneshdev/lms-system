module CommonHelper
	require 'csv'   
	PRIORITY = [['Books', '1'],['videos', '2'],['WebLinks','3']]
	SORTING = [['Highly Rated','1'],['Most viewed','2']]
	class << self

		def emailer_comment
			comments_hash = Comment.check_comments_created
    		keys = comments_hash.keys
    		keys.each do |us|
    			# binding.pry
    			user = User.find(us)
    			posts_id = comments_hash[us]
    			UserMailer.comment_reminder(user,posts_id).deliver
    		end

    		# mail(to: @user.email, subject: 'Sample Email')
		end

		def pending_posts
			User.where(role: 'admin').each do |user|
				posts = Post.where("created_at >= '#{Time.now - 4.day}' and approved = false")
				if !posts.blank?
					UserMailer.pending_requests(user,posts).deliver
				end
			end
		end

		def update_db
			csv_text = File.read('tolc.csv')
			csv = CSV.parse(csv_text, :headers => true)
			csv.each do |row|
				Book.create(title: row[6],url: row[2],image_url: row[5], category: row[0], subcategory: row[1],type: row[3],sub_type: row[4])
			end
		end

		def update
			Book.all.each do |book|
				if book.type == 'book'
					book.types = 1
				elsif book.type == 'video'
					book.types = 2
				elsif book.type == 'weblink'
					book.types = 3
				end
				book.save
			end
		end

		def update_blog_db
			csv_text = File.read('blogs.csv')
			csv_text = csv_text.tr("\r", '')
			csv = CSV.parse(csv_text)
			# csv = CSV.open('blogs.csv', :row_sep => :auto, :col_sep => ";")
			csv.each do |row|
				Post.create(category: row[0],sub_category: row[1],title: row[2], body: row[6],video_url: row[4],image_url: row[5] )
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