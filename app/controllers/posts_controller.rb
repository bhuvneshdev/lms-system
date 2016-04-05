class PostsController < ApplicationController
	def index
		@posts = Post.all.order('created_at DESC')
		binding.pry
		if !params['id'].nil? && params['id'] == 'true'
			binding.pry
			@posts = @posts.where("approved= false")
		end
		if current_user.role != 'admin'
			@posts = @posts.where("approved = true")
		end
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		# @post.save
		# redirect_to @post
		if !params[:video_url].nil?
			@post.video_url = params[:video_url]
		end
		if !params[:image_url].nil?
			@post.image_url = params[:image_url]
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

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if(@post.update(params[:post].permit(:title,:body)))
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
			params.require(:post).permit(:title,:body)
		end
end
