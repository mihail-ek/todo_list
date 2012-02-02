class Relationship < ActiveRecord::Base
  attr_accessible :follower_id, :project_id

  belongs_to :follower, :class_name => "User"
  belongs_to :followed, :class_name => "User"
  belongs_to :projects, :class_name => "Project"

  validates :follower_id, :presence => true
  validates :followed_id, :presence => true
  validates :project_id, :presence => true
end
