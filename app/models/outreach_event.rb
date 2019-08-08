class OutreachEvent < ApplicationRecord
  # NOTE: This MUST correspond to the bulma calendar dateFormat option
  DATE_FORMAT = "%d/%m/%Y"

  belongs_to :user

  attr_accessor :date_range

  def date_range
  	start_str = self.start_time.strftime(DATE_FORMAT)
  	end_str = self.end_time.strftime(DATE_FORMAT)

  	start_str + ' - ' + end_str
  end

  def date_range=(val)
  	start_str, end_str = val.split(' - ')

  	self.start_time = Date.strptime(start_str, DATE_FORMAT)
  	self.end_time = Date.strptime(end_str, DATE_FORMAT)
	end
end