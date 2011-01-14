class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link
  attr_accessible :body, :user, :link
end

