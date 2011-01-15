class Link < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  attr_accessible :title, :url, :body, :user, :tag_list
  
  acts_as_taggable_on :tags
  ActsAsTaggableOn::TagList.delimiter = " "
  
end

