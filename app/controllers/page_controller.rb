class PageController < ApplicationController

	before_action :authenticate_user!, except: [:home,:about,:faqs,:contact]
	#before_action :set_user, only: [:edit,:update]
  def home
  end

  def about
  end

  def faqs
  end

  def contact
  end

  def show
  end

  def edit1
  	@user = current_user
  	binding.pry
  end

  def edit
  	if !request.post?
	  	@preferences = ['Computer Science','Arts']
		if !params[:id].blank?
	  		@user = User.find(params[:id])
	  	else
	  		@user = current_user
	  	end
	else
		@user = User.where(email: params['email']).last
		if params['preferences'] != 'Select preferences'
			@user.preferences = params['preferences']
		end
		if params['role'] != 'Select role'
			@user.role = params['role']
		end
		@user.save
	end

  end

  def update
  	binding.pry
  	if !params['user']['id'].blank?
  		@user = User.find(params[:id])
  	else
  		@user = current_user
  	end
  	@user.update(role: params['user']['role'], preferences: params['user']['preferences'])
  	respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'user was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
