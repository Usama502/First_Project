class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :bugs, :creator_id, :user_id
  end
end
