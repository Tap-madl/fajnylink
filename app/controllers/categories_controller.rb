class CategoriesController < ApplicationController
    
  before_filter :only => [:index, :categorys] do
    @categories = Link.category_counts # for categories
  end

  def index

  end

  def categories
    @links = Link.tagged_with(params[:name])
    render 'index'
  end
end
