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
    # render "contact"
  end

  def show
  end


  def edit
  	if !request.post?
	  	@user = current_user
	else
		user_basic = params['user_basic']
		@user = User.where(email: user_basic['email']).last
		if user_basic['preferences'] != 'Select preferences'
			@user.preferences = user_basic['preferences']
		end
		if user_basic['role'] != 'Select role'
			@user.role = user_basic['role']
		end
		@user.save
	end

  end

  def update
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
