class OutreachEvent < ApplicationRecord
  # NOTE: This MUST correspond to the bulma calendar dateFormat option
  DATE_FORMAT = "%m/%d/%Y"

  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user
  has_many :outreach_event_type_assignments
  has_many :outreach_event_types, through: :outreach_event_type_assignments

  attr_accessor :date_range

  def date_range
  	date_str = ''

  	if self.start_time.present? && self.end_time.present? 
	  	start_str = self.start_time.strftime(DATE_FORMAT)
	  	end_str = self.end_time.strftime(DATE_FORMAT)

	  	date_str = start_str + ' - ' + end_str
	  end

	  date_str
  end

  def date_range=(val)
  	start_str, end_str = val.split(' - ')

  	self.start_time = Date.strptime(start_str, DATE_FORMAT)
  	self.end_time = Date.strptime(end_str, DATE_FORMAT)
	end
end