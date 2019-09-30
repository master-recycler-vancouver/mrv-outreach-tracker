class OutreachEventType < ApplicationRecord
  has_many :outreach_event_type_assignments
  has_many :outreach_events, through: :outreach_event_type_assignments
end