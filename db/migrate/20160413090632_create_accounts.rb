class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :username
      t.string :twitter_id
      t.string :display_name
      t.integer :followers_count
      t.integer :following_count
      t.references :party, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
