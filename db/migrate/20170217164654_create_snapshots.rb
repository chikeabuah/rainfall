class CreateSnapshots < ActiveRecord::Migration
  def change
    create_table :snapshots do |t|
      t.text :body, :null => false
      t.integer :session_id, :null => false
      t.timestamp :recorded_at, :null => false

      t.timestamps
    end
  end
end
