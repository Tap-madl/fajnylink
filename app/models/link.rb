class Link < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :dependent => :destroy
  attr_accessible :title, :url, :body, :user, :tag_list, :category_list
  
  acts_as_taggable_on :tags, :categorys
  ActsAsTaggableOn::TagList.delimiter = " "

  def self.search(search)
     if search
        where('title LIKE ?', "%#{search}%")
     else
        scoped
  end

end

