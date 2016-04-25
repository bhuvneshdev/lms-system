class Post < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 5}
	validates :body, presence: true
	has_many :comments, as: :commentable
	# belongs_to :user_id
	before_save :before_save_tasks
	self.inheritance_column = :_type_disabled



	def before_save_tasks
		self.body = self.body.gsub("\n","<br>")
	end
end
