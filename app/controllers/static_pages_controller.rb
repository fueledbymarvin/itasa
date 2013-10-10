class StaticPagesController < ApplicationController
	def home
		if request.headers['X-PJAX']
		    render :layout => false
		end
	end

	def about
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
end
