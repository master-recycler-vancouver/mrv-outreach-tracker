class User < ApplicationRecord
  enum role: [ :admin, :student ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :outreach_events
  has_many :collaborations
  has_many :collaborated_outreach_events, through: :collaborations, source: :outreach_event
  has_many :outreach_event_type_interests
  has_many :outreach_event_types, through: :outreach_event_type_interests

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
        .gsub("@", "")        # remove @ symbol
        .gsub(/\s+/, "")      # remove all spaces
    end

end
