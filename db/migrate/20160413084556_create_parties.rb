class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :party_name
      t.string :party_colour

      t.timestamps null: false
    end
  end
end
