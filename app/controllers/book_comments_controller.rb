class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = book.id
    if @book_comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      render :comments
    else
      render :error
    end
  end


  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    flash.now[:alert] = 'コメントを削除しました'
    @book = Book.find(params[:book_id]) 
    render :comments
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
