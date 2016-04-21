class UserMailer < ActionMailer::Base
  default from: "bhuvnesh.dev@gmail.com"

  def comment_reminder(user,post_id)
    # @user = user
    # comments_hash = Comment.check_comments_created
    # keys = comments_hash.keys
    # # binding.pry
    # keys.each do |user|
    #   binding.pry
    # 	@user = User.find(user)
    # 	@posts_id = comments_hash[user]
    # 	mail(to: @user.email, subject: 'Sample Email')
    # end
    @user = user
    @posts_id = post_id
    mail(to: @user.email, subject: 'You have been notified!!, Requests for approval')
  end

  def pending_requests(user,posts)
    @user = user
    @posts = posts
    mail(to: @user.email, subject: 'Requests for approval')
  end
end