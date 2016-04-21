class Book < ActiveRecord::Base
	has_many :comments, as: :commentable
	self.inheritance_column = :_type_disabled
end