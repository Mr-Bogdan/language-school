class Api::V1::BooksController < ApplicationController
  before_action :check_authentification, only: [:create, :update, :destroy]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  
  def index
    if !user_signed_in?
      redirect_to root_path
    else
      render json: Book.all
    end
  end

  
  def show
    if !user_signed_in?
      head :forbidden
    else
      render json: Book.find(params[:id])
    end
  end

  
  def create
    @book = current_user.books.build(book_params)
    if @book.save
     render json: @book
    else
      head :unprocessable_entity
    end
  end

  
  def update
    @book = current_user.books.find(params[:id])
    if @book.update(book_params)
      render json: @book
    else
      head :unprocessable_entity
    end
  end

  
  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy
    head :no_content
  end

  private
    
    def set_book
      @book = Book.find(params[:id])
    end
    
    def book_params
      params.require(:book).permit(:title, :description, :attachment)
    end
end

