class CreateComment < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :author, foreign_key: { to_table: 'users' }
      t.references :posts, null:false, foreign_keys:true

      t.timestamps
    end
  end
end
