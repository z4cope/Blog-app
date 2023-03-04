class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :author_id
      t.integer :post_id
      t.references :users, null:false, foreign_key: true
      t.references :posts, null:false, foreign_key: true

      t.timestamps
    end
  end
end
