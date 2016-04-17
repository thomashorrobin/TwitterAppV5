class CreateApiCallLogs < ActiveRecord::Migration
  def change
    create_table :api_call_logs do |t|
      t.string :call_description
      t.string :call_date_time
      t.boolean :successful
      t.string :end_point_path
      t.string :twitter_handle
      t.integer :records_inserted

      t.timestamps null: false
    end
  end
end
