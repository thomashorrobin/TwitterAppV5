class CreateTwitterRelationships < ActiveRecord::Migration
  def change
    create_table :twitter_relationships do |t|
      t.string :follower
      t.string :followed

      t.timestamps null: false
    end
  end
end
