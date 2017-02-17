class Session < ActiveRecord::Base
	has_many :snapshots
end
