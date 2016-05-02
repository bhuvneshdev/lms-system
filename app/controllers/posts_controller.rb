class PostsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :new, :index]
	def index
		@posts = Post.all.order('created_at DESC')
		if !params['id'].nil? && params['id'] == 'true'
			@posts = @posts.where("approved= false")
		else
			@posts = @posts.where("approved = true")
		end
		if !params['category'].nil? 
			sub = '%'+params['category']+'%'
			@posts = @posts.where("sub_category like '#{sub}'")
		end
		# if (!current_user.nil? && current_user.role == 'student') || (current_user.nil?)
		# 	@posts = @posts.where("approved = true")
		# end
	end

	def new
		@post = Post.new
		# render 'create'
		# redirect_to show_users
	end

	def create
		@post = Post.new(post_params)
		# @post.save
		# redirect_to @post
		@post.user_id = current_user.id
		if !params[:post][:video_url].nil?
			@post.video_url = params[:post][:video_url]
		end
		if !params[:post][:image_url].nil?
			@post.image_url = params[:post][:image_url]
		end
		if !params[:post][:published].nil?
			if params[:post][:published] == 'true'
				@post.published = true
			else
				@post.published = false
			end
 		end
 		type = params[:post][:type]
 		if request.post?
 			@post.type = type
 		end
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def show_users
		@user = User.all
		# render "about"
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if(@post.update(params[:post].permit(:title,:body,:video_url,:image_url,:sub_category)))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def approve
		@post = Post.find(params[:id])
		@post.approved = !@post.approved
		@post.save
		redirect_to @post
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private
		def post_params
			params.require(:post).permit(:title,:body,:sub_category)
		end
end
