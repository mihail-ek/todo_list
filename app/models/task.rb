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

  after_save do
    if ((self.updated_at == self.created_at) and (self.task_list) and (self.performer_id))
      if self.task_list.project
        Mailer.assignment(self.user, self.task_list.project.name, self.name).deliver
      end
    elsif self.task_list
      if (self.performer_id and self.task_list.project)
        Mailer.changed(self.user, self.task_list.project.name, self.name).deliver
      end
    end
  end

  attr_accessible :name, :description, :state, :priority, :performer_id, :task_list_id

  state_machine :state, initial: :not_done do
    state :not_done
    state :in_process
    state :done

    event :change_state do
      transition done: :not_done
      transition not_done: :in_process
      transition in_process: :done
    end
  end

  validates :name, :presence => true

  belongs_to :task_list
  belongs_to :user, :foreign_key => :performer_id

end
