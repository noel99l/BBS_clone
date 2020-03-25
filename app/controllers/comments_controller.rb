class CommentsController < ApplicationController
	def create
		comment = Comment.new(comment_params)
		comment.save
		redirect_to board_path(comment.board_id)
	end

	def destroy
		comment = Comment.find(params[:id])
		comment.destroy
		redirect_to board_path(comment.board_id)
	end

	private
    def comment_params
      params.require(:comment).permit(:user_id, :board_id, :comment)
    end
end
