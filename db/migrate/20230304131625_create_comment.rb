class CreateComment < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :author_id
      t.integer :post_id
      t.text :text
      t.references :users, null:false, foreign_keys:true
      t.references :posts, null:false, foreign_keys:true

      t.timestamps
    end
  end
end
