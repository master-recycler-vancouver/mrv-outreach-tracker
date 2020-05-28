# frozen_string_literal: true

class User < ApplicationRecord
  enum role: %i[admin student facilitator]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable

  attr_accessor :skip_password_validation # virtual attribute to skip password validation while saving

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

  VALID_IMPORT_COLUMNS = %i[
    first_name
    last_name
    email
    role
    cohort_id
    facebook_handle
    instagram_handle
    linkedin_handle
    twitter_handle
  ].freeze

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

  def clean_social_link(val)
    return val if val.nil?

    val
      .downcase
      .gsub('@', '')        # remove @ symbol
      .gsub(/\s+/, '')      # remove all spaces
  end

  def self.invite_from_csv(file)
    # STEP 1: grab and transform user data
    user_data = []
    CSV.foreach(file.path, headers: true) do |row|
      sanitized_row = UserDataTransformer.new(row).call
      user_data << sanitized_row
    end

    # STEP 2: Attempt to create the users
    created_users = []
    User.transaction do
      user_data.each do |data|
        user = User.where(email: data[:email]).first_or_initialize.tap do |u|
          u.assign_attributes(data)
          u.save!
        end
        created_users << user
      end
    end

    # STEP 3: Invite users
    # By using the transaction, created_users won't be populated if an error is thrown.
    # We will only get here if all users are created successfully. Woo!
    created_users.each(&:invite!)
  rescue StandardError => e
    # bubble up errors to the controller
    raise e
  end

  private

  def student_belongs_to_cohort
    errors.add(:cohort_id, 'student must belong to a chort') if student? && cohort_id.blank?
  end

  def password_required?
    return false if skip_password_validation

    super
  end
end
