class Project < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :project_conversations_histories

  enum :status, [:created, :ongoing, :blocked, :completed]

  after_create :create_project_conversations_history

  def project_conversations_history_log
    project_conversations_histories.order(created_at: :asc).map do |history|
      history.history_log
    end
  end

  private

  def create_project_conversations_history
    self.project_conversations_histories.create!(user: self.user, action: :changed_status, comment: '', status: self.status)
  end
end