class Member < ActiveRecord::Base
  	attr_accessible :college, :email, :fact, :hometown, :major, :name, :place, :position, :year, :fbid
  	validates_presence_of :college, :email, :fact, :hometown, :major, :name, :place, :position, :year

  	def admin_id?
		admins = Member.all.map { |member| member.fbid }
		# push non-board admin ids here
		admins.include?(self.fbid)
	end
end
