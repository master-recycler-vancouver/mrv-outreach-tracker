# frozen_string_literal: true

class UserDataTransformer
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def call
    # clean up data in case user accidentally adds a field we don't want to override (ie. id)
    current_time = Time.current
    sanitized_csv_data = data.to_h.symbolize_keys.slice(*User::VALID_IMPORT_COLUMNS)

    sanitized_csv_data.tap do |h|
      h[:updated_at] = current_time
      h[:created_at] = current_time
      h[:role] = data['role'] || User.roles[:student] # default to student
      h[:skip_password_validation] = true
    end
  end
end
