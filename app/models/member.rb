class Member < ActiveRecord::Base
  	attr_accessible :college, :dept, :email, :fact, :hometown, :major, :name, :place, :position, :year, :fbid
  	validates_presence_of :college, :dept, :email, :fact, :hometown, :major, :name, :place, :position, :year

  	def admin_id?
		admins = Member.all.map { |member| member.fbid }
		admins.include?(self.fbid)
	end

	def self.dept_names
		["Directors", "Marketing", "Programming", "Finance", "Logistics"]
	end
end
