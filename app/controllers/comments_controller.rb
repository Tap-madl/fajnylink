# -*- coding: utf-8 -*-
class CommentsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :authorize_user_destroy, :only => [:destroy]
  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.create(params[:comment])
    @comment.user = current_user
    @comment.save
    redirect_to link_path(@link)
  end

  def destroy
    @comment.destroy
    redirect_to link_path(@link)
  end

  protected

  def authorize_user_destroy
    @link = Link.find(params[:link_id])
    @comment = @link.comments.find(params[:id])
    if @comment.user != current_user
      redirect_to link_path(@link)
      flash[:notice] = "Brak uprawnien."
    end
  end

end