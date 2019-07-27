class OutreachEvent < ApplicationRecord
  belongs_to :user

  attr_accessor :date_range

  def date_range=(val)
  	start_str, end_str = val.split(' - ')

  	self.start_time = start_str
  	self.end_time = end_str
	end
end