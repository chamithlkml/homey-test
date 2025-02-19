class ProjectConversationsHistory < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum :action, [:commented, :changed_status]

  validate :comment_presence_if_action_is_commented
  validate :status_presence_if_action_is_changed_status
  validate :status_is_valid_project_status

  def human_action
    self.class.human_enum_name(:action, action)
  end

  def history_log
    log_message = "#{user.name} #{human_action}"

    log_message += case action
                    when 'commented'
                      " and the comment is : #{comment}"
                    when 'changed_status'
                      " to #{status}"
                    else
                      ""
                    end
  end

  private

  def comment_presence_if_action_is_commented
    if action == 'commented' && comment.blank?
      errors.add(:comment, "can't be blank if action is commented")
    end
  end

  def status_presence_if_action_is_changed_status
    if action == 'changed_status' && status.blank?
      errors.add(:status, "can't be blank if action is changed status")
    end
  end

  def status_is_valid_project_status
    if action == 'changed_status' && !Project.statuses.keys.include?(status)
      errors.add(:status, "is not a valid project status")
    end
  end
end
