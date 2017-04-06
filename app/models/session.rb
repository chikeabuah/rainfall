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

	def solution_rp?
		sorted_snapshots = snapshots.sort_by {|s| s.recorded_at}
		rpflags = ["break", "while(1)", "boolean cont = true; while(cont)", "while (not rainfall)",
		"currentNum = 0; while(currentNum != 99999){ scanf", "do", "while(scanf"]
		rpflags.any? { |word| sorted_snapshots.last.body.include?(word) }
	end

	def rp_years
		b = self.solution_rp?
		if b
			self.experience_years.to_i
		else
			nil
		end
	end

	def pr_years
		b = self.solution_pr?
		if b
			self.experience_years.to_i
		else
			nil
		end
	end

	

	def solution_pr?
		sorted_snapshots = snapshots.sort_by {|s| s.recorded_at}
		sorted_snapshots.last.body.scan(/scanf/).count > 1
	end


	def solution_attempt?
		sorted_snapshots = snapshots.sort_by {|s| s.recorded_at}
		rpflags = ["99999"]
		rpflags.any? { |word| sorted_snapshots.last.body.include?(word) }
	end


end
