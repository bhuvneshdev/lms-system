class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
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
  end

  def search_result
    binding.pry
    if !request.post?
      if !current_user.nil? && !current_user.preferences.blank?
        @book = Book.where("category = '#{current_user.preferences}'").limit(10)
      else
        @book = Book.all.limit(10)
      end
      if @book.blank?
        @book = Book.all.limit(10)
      end
    else
      if !params['search'].blank?
        @book = Book.where("title like '%#{params['search']}%' or category like '%#{params['search']}%' or subcategory like '%#{params['search']}%'")
      end
    end
  end

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
