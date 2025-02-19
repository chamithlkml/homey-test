require_relative '../rails_helper'

RSpec.describe Project, type: :model do
  fixtures :users

  describe 'Project conversation histories' do
    it 'Should be a valid' do
      user_one = users(:one)
      project = Project.create(name: 'Test Project', user: user_one, status: :created)

      user_two = users(:two)
      # No comment added
      empty_comment_history = ProjectConversationsHistory.create(project: project, user: user_two, action: :commented)
      expect(empty_comment_history).not_to be_valid

      # No status added
      empty_status_history = ProjectConversationsHistory.create(project: project, user: user_two, action: :changed_status)
      expect(empty_status_history).not_to be_valid

      # Invalid status added
      invalid_status = ProjectConversationsHistory.create(project: project, user: user_two, action: :changed_status, status: 'invalid_status')
      expect(invalid_status).not_to be_valid
    end
  end
end