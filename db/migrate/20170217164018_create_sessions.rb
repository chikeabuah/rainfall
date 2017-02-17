class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :current_status, :null => false
      t.float :experience_years, :null => false
      t.boolean :cs_major, :null => false
      t.string :alternative_language, :default => "C", :null => false

      t.timestamps
    end
  end
end
