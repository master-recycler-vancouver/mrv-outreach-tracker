class OutreachEvent < ApplicationRecord
	DATE_FORMAT = "%m/%d/%Y"

  belongs_to :user

  attr_accessor :date_range

  def date_range=(val)
  	start_str, end_str = val.split(' - ')

  	p start_str

  	self.start_time = Date.strptime(start_str, DATE_FORMAT)
  	self.end_time = Date.strptime(end_str, DATE_FORMAT)
	end
end