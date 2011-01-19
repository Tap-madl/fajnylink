# -*- coding: utf-8 -*-
class LinksController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /links
  # GET /links.xml
  before_filter :authorize_user_read, :except => [:show, :index, :new, :create, :tags, :categorys]   
  before_filter :authenticate_user!, :only => [:new, :create]
  
  before_filter :only => [:index, :tags, :categorys] do
    @tags = Link.where(:private => false).tag_counts  # for tag clouds
    @categories = Link.category_counts # for categorys
  end
  
  
  def index
    @links = Link.search(params[:search]).where(:private => false).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])

  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])
    @link.comments_amount = @link.comments.length
    @link.save
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])
    @link.user = current_user
    if @link.save
      flash[:notice] = "Successfully created link."
      redirect_to @link
    else
      render :action => 'new'
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      flash[:notice] = "Successfully updated link."
      redirect_to @link
    else
      render :action => 'edit'
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    flash[:notice] = "Successfully destroyed link."
    redirect_to links_url
  end
  
  
  
  def tags
    @links = Link.tagged_with(params[:name]).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    render 'index'
  end
  
  
  def categories
    @links = Link.tagged_with(params[:name]).search(params[:search]).order(sort_column + " " + sort_direction).paginate(:per_page => 5, :page => params[:page])
    render 'index'
  end

  protected

  def authorize_user_read
    @link = Link.find(params[:id])
    if @link.user != current_user
      redirect_to links_url
      flash[:notice] = "Brak uprawnień."
    end
  end

  private
  def sort_column 
    Link.column_names.include?(params[:sort]) ? params[:sort] : "title" 
  end 

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc" 
  end

end
