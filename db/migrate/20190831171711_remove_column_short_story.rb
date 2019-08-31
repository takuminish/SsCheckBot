class RemoveColumnShortStory < ActiveRecord::Migration[5.2]
  def up
    remove_column :shortstories, :image
  end

  def down
    add_column :shortstories, :image
  end
end
