class CreateIssuesIssues < ActiveRecord::Migration
  def change
    create_table :issues_issues do |t|
      t.integer :id
      t.integer :user_id, :null => false
      t.integer :project_id, :null => false
      t.string :title, :null => false
      t.text :description

      t.timestamps
    end

    add_index :issues_issues, [:user_id, :project_id]
  end
end
