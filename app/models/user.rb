# frozen_string_literal: true

class User < ApplicationRecord
  enum role: %i[admin student facilitator]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :interests

  has_many :outreach_events
  has_many :collaborations
  has_many :collaborated_outreach_events, through: :collaborations, source: :outreach_event
  has_many :outreach_event_type_interests
  has_many :outreach_event_types, through: :outreach_event_type_interests
  has_one_attached :picture
  belongs_to :cohort, optional: true

  validate :student_belongs_to_cohort

  def full_name
    "#{first_name} #{last_name}"
  end

  def facebook_handle=(val)
    write_attribute(:facebook_handle, clean_social_link(val))
  end

  def instagram_handle=(val)
    write_attribute(:instagram_handle, clean_social_link(val))
  end

  def linkedin_handle=(val)
    write_attribute(:linkedin_handle, clean_social_link(val))
  end

  def twitter_handle=(val)
    write_attribute(:twitter_handle, clean_social_link(val))
  end

  private

  def clean_social_link(val)
    val
      .downcase
      .gsub('@', '')        # remove @ symbol
      .gsub(/\s+/, '')      # remove all spaces
  end

  def student_belongs_to_cohort
    errors.add(:cohort_id, 'student must belong to a chort') if student? && cohort_id.blank?
  end
end
