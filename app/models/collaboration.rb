class Collaboration < ApplicationRecord
  belongs_to :user
  belongs_to :outreach_event
end