class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  respond_to :html

  def index
    @books = Book.all
    respond_with(@books)
  end

  def show
    respond_with(@book)
  end

  def new
    @book = Book.new
    respond_with(@book)
  end

  def edit
  end

  def details
    @book = Book.find(params[:id])
    @book.view_count = 1 if @book.view_count.nil?
    view_count = @book.view_count + 1
    @book.update(view_count: view_count)
    if !@book.nil? && !current_user.nil?
      @comments = @book.comments.where(user_id: current_user.id)
    end
    if request.post?
      rating1 = params['rating1']
      rating2 = params['rating2']
      rating3 = params['rating3']
      rating4 = params['rating4']
      rating5 = params['rating5']
      rating6 = params['rating6']
      rating7 = params['rating7']
      rating8 = params['rating8']
      user_basics = params['user_basic']
      # "title"=>"English Grammar", "author_name"=>"", "type"=>"book", "sub_type"=>"grammar", "category"=>"english", "subcategory"=>"Geography"}
      @book.title = user_basics['title'] if !user_basics['title'].nil?
      @book.author_name = user_basics['author_name'] if !user_basics['author_name'].nil?
      @book.type = user_basics['type'] if !user_basics['type'].nil?
      @book.sub_type = user_basics['sub_type'] if !user_basics['sub_type'].nil?
      @book.category = user_basics['category'] if !user_basics['category'].nil?
      @book.subcategory = user_basics['subcategory'] if !user_basics['subcategory'].nil?

      rating1,rating2,rating3,rating4,rating5,rating6,rating7,rating8 = BooksRating.update_rating(@book.id,current_user.id,rating1,rating2,rating3,rating4,rating5,rating6,rating7,rating8)
      @book.rating1 = rating1
      @book.rating2 = rating2
      @book.rating3 = rating3
      @book.rating4 = rating4
      @book.rating5 = rating5
      @book.rating6 = rating6
      @book.rating7 = rating7
      @book.rating8 = rating8
      @book.save
      if params['commit'] == "Submit"
        if !params['comment'].nil?
          feedback = params['comment']
          Comment.create(commentable_type: 'Book',commentable_id: @book.id,user_id: current_user.id,feedback: feedback)
        else
          @message = "Comment can't be null"
        end
      end
    end
    @overall_rating = BooksRating.over_all_rating(@book.id).to_s
  end

  def search_result
    @book = ''
    @message = ''
    if !request.post?
      if !current_user.nil? && !current_user.preferences.blank?
        @book = Book.where("category = '#{current_user.preferences}' OR description = '#{current_user.preferences}'").limit(16)
      else
        @book = Book.all
      end
      if @book.blank?
        @book = Book.all.limit(16)
      end
    else
      if !params['search'].blank?
        @book = Book.where("title like '%#{params['search']}%' or category like '%#{params['search']}%' or subcategory like '%#{params['search']}%'")
      end
      if @book.blank?
        @book = Book.all
      end
      if !params['sub_type'].nil? && params['sub_type'] != '0' && (params['type'] != '1' || session['type'] != '1')
        @message = 'Sub category can only be selected under Books category'
      elsif params['sub_type'] != '0'
        @book = @book.where(sub_type: params['sub_type'])
      end
    end
    # if (session['sorting'] == params['sorting'] && !params['sorting'].nil? && params['sorting'] != '0')
    #   # @book = @book.where(sorting: params['sorting'].to_i)
    # end
    if (params['type'] == '0')
      session['type'] = '0'
    elsif (params['type'] == '1')
      session['type'] = '1'
      # @book = @book.where(types: 1)
    elsif (params['type'] == '2')
      session['type'] = '2'
      # @book = @book.where(types: 2)
    elsif (params['type'] == '3')
      session['type'] = '3'
      # @book = @book.where(types: 3)
    end
    if (session['type'] == params['type'] && !params['type'].nil? && params['type'] != '0')
      @book = @book.where(types: params['type'].to_i)
    end

    if (params['sorting'] == '0')
      session['sorting'] = '0'
    elsif (params['sorting'] == '1')
      session['sorting'] = '1'
      @book = @book.order("rating desc")
    elsif (params['sorting'] == '2')
      session['sorting'] = '2'
      @book = @book.order("view_count desc")
    end
  end

  # def create_comment
  #   binding.pry
    # if @book.nil? && !current_user.nil?
    #   @comments = @book.comments.where(user_id: current_user.id)
    # end
  #   if request.post?
  #     binding.pry
  #     Comment.create(commentable_type: 'Book',commentable_id: @book.id,user_id: current_user.id,feedback: feedback)
  #     binding.pry
  #   end
  # end

  def create
    @book = Book.new(book_params)
    @book.save
    respond_with(@book)
  end

  def update
    @book.update(book_params)
    respond_with(@book)
  end

  def destroy
    @book.destroy
    respond_with(@book)
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :description, :url, :image_url, :price, :category, :subcategory, :rating)
    end

end
