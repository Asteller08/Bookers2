class BooksController < UsersController
  before_action :authenticate_user!, except: :top
  def top
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def show
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :edit
    end
  end

  def create
    public_method(:index).super_method.call
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash[:notice] = "error"
      render :index
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def baria_user
    unless Book.find(params[:id]).user.id.to_i == current_user.id
        redirect_to books_path(@book.id)
    end
  end
end
