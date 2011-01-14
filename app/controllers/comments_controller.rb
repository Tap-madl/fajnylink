class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.create(params[:comment])
    @comment.user = current_user
    @comment.save
    redirect_to link_path(@link)
  end
end