class BooksRating < ActiveRecord::Base

	def self.over_all_rating(book_id)
		all = BooksRating.where(book_id: book_id)
		book = Book.find book_id
		sum = 0
		sum_rating = 0.0
		rating = 0
		if !all.empty?
			all.each {|x| sum_rating += ((fix_rating(x.rating1)+fix_rating(x.rating2)+fix_rating(x.rating3)+fix_rating(x.rating4)+fix_rating(x.rating5)+fix_rating(x.rating6)+fix_rating(x.rating7)+fix_rating(x.rating8)).to_f/8); sum += 1}
			rating = sum_rating.to_f/sum
			# binding.pry
			book.rating = rating
			book.save
			return rating
		else
			return rating
		end
	end

	def self.update_rating(book_id,user_id,rating1,rating2,rating3,rating4,rating5,rating6,rating7,rating8)
		book_rate = BooksRating.where(book_id: book_id,user_id: user_id).last
		if !book_rate.nil?
			book_rate.rating1 = rating1.to_i
			book_rate.rating2 = rating2.to_i
			book_rate.rating3 = rating3.to_i
			book_rate.rating4 = rating4.to_i
			book_rate.rating5 = rating5.to_i
			book_rate.rating6 = rating6.to_i
			book_rate.rating7 = rating7.to_i
			book_rate.rating8 = rating8.to_i
			book_rate.rating = rating1.to_i + rating2.to_i + rating3.to_i + rating4.to_i + rating5.to_i + rating6.to_i + rating7.to_i + rating8.to_i
			book_rate.save
		else
			book_rate = BooksRating.create(book_id: book_id,user_id: user_id, rating1: rating1,rating2: rating2,rating3: rating3,rating4: rating4,rating5: rating5,rating6: rating6,rating7: rating7,rating8: rating8)
		end
		return book_rate.rating1,book_rate.rating2,book_rate.rating3,book_rate.rating4,book_rate.rating5,book_rate.rating6,book_rate.rating7,book_rate.rating8
	end

	def self.fix_rating(value)
		if value.nil?
			1
		else
			value
		end
	end

	def self.update_db(book_id)
		all = BooksRating.where(book_id: book_id)
		book = Book.find book_id
		sum = 0
		sum_rating = 0.0
		rating = 0
		if !all.empty?
			all.each {|x| sum_rating += ((fix_rating(x.rating1)+fix_rating(x.rating2)+fix_rating(x.rating3)+fix_rating(x.rating4)+fix_rating(x.rating5)+fix_rating(x.rating6)+fix_rating(x.rating7)+fix_rating(x.rating8)).to_f/8); sum += 1}
			rating = sum_rating.to_f/sum
			book.rating = rating
			book.save
			return rating
		else
			return rating
		end
	end

	def self.update
		Book.all.each {|x| update_db(x.id)}
	end

end
