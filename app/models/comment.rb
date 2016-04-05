class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
	# belongs_to :user#, through: :user_id

	def self.check_comment_tagging(text)
		arr = []
		text.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i) do |username|
			user = User.where(email: username).last
			arr << user.id if !user.nil?
		end
		return arr
	end

	def self.check_comments_created
		comments = Comment.where("created_at >= '#{Time.now - 1.day}' and commentable_type = 'Post'")
		hash = Hash.new
		if !comments.blank?
			
			comments.each do|comment|
				arr = check_comment_tagging(comment.feedback)
				if !arr.blank?
					arr.each do |x|
						if hash.keys.include?(x)
							hash[x] << comment.commentable_id 
						else
							hash[x] = [comment.commentable_id]
						end
					end
				end
			end
		end
		return hash
	end
end
