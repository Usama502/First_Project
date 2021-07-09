class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.string :description
      t.string :type
      t.string :status
      t.datetime :deadline
      t.integer :project_id
      t.integer :creator_id
      t.integer :developer_id
    end
  end
end
