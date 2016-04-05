class UserMailer < ActionMailer::Base
  default from: "bhuvnesh.dev@gmail.com"

  def comment_reminder()
    # @user = user
    comments_hash = Comment.check_comments_created
    keys = comments_hash.keys
    keys.each do |user|
    	@user = User.find(user)
    	@posts_id = comments_hash[user]
    	mail(to: @user.email, subject: 'Sample Email')
    end
  end
end