class BooksRating < ActiveRecord::Base

	def self.over_all_rating(book_id)
		all = BooksRating.where(book_id: book_id)
		sum = 0
		sum_rating = 0.0
		rating = 0
		if !all.empty?
			all.each {|x| sum_rating += ((x.rating1+x.rating2+x.rating3+x.rating4+x.rating5).to_f/5); sum += 1}
			rating = sum_rating.to_f/sum
			return rating
		else
			return rating
		end
	end

	def self.update_rating(book_id,user_id,rating1,rating2,rating3,rating4,rating5)
		book_rate = BooksRating.where(book_id: book_id,user_id: user_id).last
		if !book_rate.nil?
			book_rate.rating1 = rating1.to_i
			book_rate.rating2 = rating2.to_i
			book_rate.rating3 = rating3.to_i
			book_rate.rating4 = rating4.to_i
			book_rate.rating5 = rating5.to_i
			book_rate.rating = rating1.to_i + rating2.to_i + rating3.to_i + rating4.to_i + rating5.to_i
			book_rate.save
		else
			book_rate = BooksRating.create(book_id: book_id,user_id: user_id, rating1: rating1,rating2: rating2,rating3: rating3,rating4: rating4,rating5: rating5)
		end
		return book_rate.rating1,book_rate.rating2,book_rate.rating3,book_rate.rating4,book_rate.rating5
	end

end
