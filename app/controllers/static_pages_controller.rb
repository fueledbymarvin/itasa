class StaticPagesController < ApplicationController
	def home
		if request.headers['X-PJAX']
		    render :layout => false
		end
	end

	def about
		if request.headers['X-PJAX']
		    render :layout => false #add this option to save the time of layout rendering
		end
	end

	def team
		@dept_names = Member.dept_names
		@depts = {}
		@dept_names.each do |department|
			@depts[department] = Member.where(dept: department)
		end
		if request.headers['X-PJAX']
		    render :layout => false #add this option to save the time of layout rendering
		end
	end

	def register
		if request.headers['X-PJAX']
		    render :layout => false #add this option to save the time of layout rendering
		end
	end

	def schedule
		if request.headers['X-PJAX']
		    render :layout => false #add this option to save the time of layout rendering
		end
	end

	def contact
		if request.headers['X-PJAX']
		    render :layout => false #add this option to save the time of layout rendering
		end
	end

	def sponsor
		@colleges = ["Yale University", "Princeton University", "Harvard University", "Massachusetts Institute of Technology", "Columbia University", "University of Pennsylvania", "Cornell University", "Brown University", "New York University", "Carnegie Mellon University", "Johns Hopkins University", "Rutgers University", "University of Maryland", "Boston College", "Wellesley College"]
		if request.headers['X-PJAX']
		    render :layout => false #add this option to save the time of layout rendering
		end
	end
end
