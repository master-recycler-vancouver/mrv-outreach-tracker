if ENV["ADMIN_USER_EMAIL"].present? && ENV["ADMIN_USER_PASSWORD"].present?
  admin = User.where(email: ENV["ADMIN_USER_EMAIL"]).first_or_initialize(
    password: ENV["ADMIN_USER_PASSWORD"],
    password_confirmation: ENV["ADMIN_USER_PASSWORD"],
    role: :admin
  )
  admin.save!
end

if Rails.env.development?
  cohort = Cohort.create(name: "Test Cohort")
  User.roles.keys.each do |role|
    user = User.where(email: "#{role}@example.com").first_or_initialize(
      password: "password",
      password_confirmation: "password",
      role: role
    )

    user.cohort = cohort if user.student?
    user.save!
  end
end