class CreateShortstoryTags < ActiveRecord::Migration[5.2]
  def change
    create_table :shortstory_tags do |t|
      t.references :shortstory, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
