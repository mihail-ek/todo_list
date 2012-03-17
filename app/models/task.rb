# == Schema Information
#
# Table name: tasks
#
#  id           :integer         not null, primary key
#  name         :string(255)
#  description  :text
#  state        :boolean         default(FALSE)
#  priority     :integer         default(0)
#  task_list_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Task < ActiveRecord::Base
  attr_accessible :name, :description, :state, :priority, :performer_id

  symbolize :state, :in => [:"Not done", :"In process", :"Done"], :scopes => true, :i18n => false

  validates :name, :presence => true

  belongs_to :task_list
  belongs_to :user, :foreign_key => :performer_id
end
