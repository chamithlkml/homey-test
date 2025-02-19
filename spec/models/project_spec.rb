require_relative '../rails_helper'

RSpec.describe Project, type: :model do
  fixtures :users

  describe 'Project validations' do
    it 'should not be valid without a name' do
      project = Project.new(user: users(:one), status: :created)
      expect(project).not_to be_valid
    end

    it 'should be valid with a unique name only' do
      project = Project.create(name: 'Some Project', user: users(:one), status: :created)
      expect(project).to be_valid
      duplicated_project = Project.create(name: 'Some Project', user: users(:one), status: :created)
      expect(duplicated_project).not_to be_valid
    end
  end

  describe 'Project associations' do
    it 'project belongs to a user and user has many projects' do
      user = users(:one)
      project = Project.create(name: 'Test Project', user: user, status: :created)
      expect(project.user).to eq(user)
      expect(user.projects).to include(project)
      # Project creation should create a project_conversations_history entry
      expect(project.project_conversations_histories.count).to eq(1)
    end
  end

  describe 'project conversation history changed' do
    it 'should return the log array' do
      user_one = users(:one)
      project = Project.create(name: 'Test Project', user: user_one, status: :created)

      user_two = users(:two)
      changed_status = ProjectConversationsHistory.create(project: project, user: user_two, action: :changed_status, status: :ongoing)
      expect(changed_status.history_log).to eq('Second changed status to ongoing')
      commented = ProjectConversationsHistory.create(project: project, user: user_one, action: :commented, comment: 'Some comment')
      expect(commented.history_log).to eq('First commented and the comment is : Some comment')
      expect(project.project_conversations_history_log).to eq(["First changed status to created", "Second changed status to ongoing", "First commented and the comment is : Some comment"])
    end
  end
end