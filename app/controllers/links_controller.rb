# -*- coding: utf-8 -*-
class LinksController < ApplicationController
  # GET /links
  # GET /links.xml
  before_filter :authorize_user_read, :except => [:show, :index, :new, :create, :tags]   
  before_filter :authenticate_user!, :only => [:new, :create]
  
  before_filter :only => [:index, :tags] do
    @tags = Link.tag_counts  # for tag clouds
  end
  
  
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/1
  # GET /links/1.xml
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
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
    respond_to do |format|
      if @link.save
        format.html { redirect_to(@link, :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(@link, :notice => 'Link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def tags
    @links = Link.tagged_with(params[:name])
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
end
