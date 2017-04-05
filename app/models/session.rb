class Session < ActiveRecord::Base
	has_many :snapshots

	def time_taken
		sorted_snapshots = snapshots.sort_by {|s| s.recorded_at}
		sorted_snapshots.last.recorded_at - sorted_snapshots.first.recorded_at
	end

	def solution_length
		sorted_snapshots = snapshots.sort_by {|s| s.recorded_at}
		sorted_snapshots.last.body.squish.length
	end
end
