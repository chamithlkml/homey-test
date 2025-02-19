class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
