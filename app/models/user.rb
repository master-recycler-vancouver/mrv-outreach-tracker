class User < ApplicationRecord
  enum role: [ :admin, :student ]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :outreach_events

  def full_name
    "#{first_name} #{last_name}"
  end

end
