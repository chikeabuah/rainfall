namespace :rainfall do
  task :analysis => :environment do
  	class Array
		  def sum
		    inject(0.0) { |result, el| result + el }
		  end

		  def mean 
		    sum / size
		  end

		end
		# the ruby way
		def variance(lst)
			m = lst.mean
			sum = 0.0
			lst.each { |v| sum += (v-m)**2 }
			sum/lst.size
		end

		def sigma(lst)
			Math.sqrt(variance(lst))
		end

		def correlate(v)
			sum = 0.0
			v.each do |a|
				sum += a[0]*a[1]
			end
			xymean = sum/v.size.to_f
			x = v.collect {|a| a[0]}
			y = v.collect {|a| a[1]}
			xmean = x.mean
			ymean = y.mean
			sx = sigma(x)
			sy = sigma(y)
			(xymean-(xmean*ymean))/(sx*sy)
		end

    puts "Beginning rainfall data analysis..."
    # manually fix "thirty"
    # manually fix "1000"
    # coerce the rest to integers
    # Session.all.each do |session|
    # 	session.experience_years = session.experience_years[/\d+/]
    # 	session.save
    # end
    ActiveRecord::Base.logger.silence do
	    valid_sessions = []
	    Session.all.each do |s|
	    	unless s.snapshots.empty?
	    		valid_sessions << s
	    	end
	   	end
	   	valid_ids = valid_sessions.map(&:id)
	   	valid_sessions = Session.where(id: valid_ids)
	    puts "Total Sessions: #{valid_sessions.count}"
	    puts "Total Sessions in C: #{valid_sessions.where("language ilike 'C'").count}"
	    puts "Total Sessions in Java: #{valid_sessions.where("language ilike 'Java'").count}"
	    puts "Total Sessions in Python: #{valid_sessions.where("language ilike 'Python'").count}"
	    puts "Total Sessions in C#: #{valid_sessions.where("language ilike 'C#'").count}"
	    puts "Total Sessions in Javascript: #{valid_sessions.where("language ilike 'Javascript'").count}"
	    puts "Total Sessions in C++: #{valid_sessions.where("language ilike 'C++'").count}"
	    puts "Total Sessions in OCaml: #{valid_sessions.where("language ilike 'OCaml'").count}"
	    puts "Total Sessions in Ruby: #{valid_sessions.where("language ilike 'Ruby'").count}"
	    puts "Total Sessions in Racket: #{valid_sessions.where("language ilike 'Racket'").count}"

	    puts "Average experience in C: #{valid_sessions.where("language ilike 'C'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in Java: #{valid_sessions.where("language ilike 'Java'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in Python: #{valid_sessions.where("language ilike 'Python'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in C#: #{valid_sessions.where("language ilike 'C#'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in Javascript: #{valid_sessions.where("language ilike 'Javascript'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in C++: #{valid_sessions.where("language ilike 'C++'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in OCaml: #{valid_sessions.where("language ilike 'OCaml'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in Ruby: #{valid_sessions.where("language ilike 'Ruby'").all.map { |s| s.experience_years.to_i }.mean}"
	    puts "Average experience in Racket: #{valid_sessions.where("language ilike 'Racket'").all.map { |s| s.experience_years.to_i }.mean}"
	  	
	  	experience = valid_sessions.all.map {|v| v.experience_years.to_f}

	  	puts "Avg TOTAL experience: #{experience.mean}"
	  	puts "Avg TIME taken: #{valid_sessions.all.map {|s| s.time_taken}.mean/60} minutes"
	  	puts "STD DEV TIME taken: #{sigma(valid_sessions.all.map {|s| s.time_taken})/60} minutes"


	  	puts "STD DEV TOTAL experience: #{sigma(experience)}"

	  	snapshot_counts = Snapshot.group(:session_id).count.to_a.map { |a| a[1] }
	  	puts "Average number of snapshot counts: #{snapshot_counts.mean}"
	  	puts "Std Dev of #snapshots: #{sigma(snapshot_counts)}"
	  	puts "Pasted code samples: #{snapshot_counts.count(1)}"

	  	exp_to_snaps = Session.joins(:snapshots).group(:session_id, :experience_years).count.to_a.map { |v| [v[0][1].to_f,v[1]] }
	  	puts "Correlation of experience_years to snapshot_counts: #{correlate(exp_to_snaps)}"
	  
	  	exp_to_duration = valid_sessions.all.map {|s| [s.experience_years.to_f,s.time_taken]}
	  	exp_to_solution_len = valid_sessions.all.map {|s| [s.experience_years.to_f,s.solution_length]}

	  	puts "Correlation of experience_years to coding duration: #{correlate(exp_to_duration)}"
	  	puts "Correlation of experience_years to character length of solution: #{correlate(exp_to_solution_len)}"



	  end

  end
end