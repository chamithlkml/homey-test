class CreateProjectConversationsHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :project_conversations_histories do |t|
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :action, default: 0, null: false
      t.text :comment, null: false, default: ''
      t.string :status, null: false, default: ''

      t.timestamps
    end
  end
end
