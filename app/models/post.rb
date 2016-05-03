class Post < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 5}
	validates :body, presence: true
	has_many :comments, as: :commentable
	# belongs_to :user_id
	before_save :before_save_tasks
	self.inheritance_column = :_type_disabled


	def email_comments
		id = self.id
		arr = []
		cat1 = self.sub_category
		# binding.pry
		Post.all.each do |x|
			if (!x.sub_category.nil? && !cat1.nil? && (x.sub_category.downcase.include?(cat1.downcase) || cat1.downcase.include?(x.sub_category.downcase)))
				x.comments.each {|x| arr << x.email_id if !x.email_id.nil?}
			end
		end
		return arr.uniq
	end

	def before_save_tasks
		self.body = self.body.gsub("\n","<br>")
	end
end
