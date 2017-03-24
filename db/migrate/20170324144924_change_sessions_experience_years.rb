class ChangeSessionsExperienceYears < ActiveRecord::Migration
  def change
  	change_column :sessions, :experience_years, :string
  end
end
