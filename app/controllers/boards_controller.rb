class BoardsController < ApplicationController
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :login?, except: [:index, :show]

  def index
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = Board.ransack(search_params, activated: true)
      @title = "掲示板検索結果"
    else
      @q = Board.ransack(activated: true)
      @title = "掲示板一覧"
    end
    @boards = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @categories = Category.all
  end

  def show
    @comments = Comment.where(board_id: @board.id)
    @categories = Category.where(board_id: @board.id)
    @comment = Comment.new
  end

  def new
    @board = Board.new
    @category = @board.categories.build
  end

  def confirm
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: 'スレッドを新規に作成しました！' }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: 'スレッドを削除しました！' }
      format.json { head :no_content }
    end
  end

  private
    def set_board
      @board = Board.find(params[:id])
    end

    def login?
      unless user_signed_in?
        redirect_to root_path
      end
    end

    def board_params
      params.require(:board).permit(:user_id, :title, :body, categories_attributes: [:id, :board_id, :category, :_destroy])
    end

    def search_params
      params.require(:q).permit(:title_or_body_or_categories_category_or_comments_comment_cont_any)
    end
end
