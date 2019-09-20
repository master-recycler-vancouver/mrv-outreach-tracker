class OutreachEvent < ApplicationRecord
  # NOTE: This MUST correspond to the bulma calendar dateFormat option
  DATE_FORMAT = "%m/%d/%Y"

  belongs_to :user
  has_many :collaborations
  has_many :collaborators, through: :collaborations, source: :user

  validates_presence_of :start_time, :end_time
  validate :end_time_after_start_time
  validate :duration_in_valid_interval

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
  
  private

    def end_time_after_start_time
      if start_time >= end_time
        errors.add(:end_time, "must be after start time")
      end
    end

    def duration_in_valid_interval
      errors.add(:duration_in_minutes, "must be a multiple of 15 minutes") if duration_in_minutes % 15 != 0
    end

end