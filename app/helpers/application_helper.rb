module ApplicationHelper
  TRUNCATE_LIMIT = 64

  def navbar_user_class
    if current_user && current_user.admin?
      "is-dark"
    else
      "is-white"
    end
  end

  def format_date(date)
    date.strftime("%m/%d/%Y")
  end

  def flash_type_class(flash_type)
    case flash_type.to_sym
    when :alert, :danger, :error
      "is-warning"
    when :notice, :success
      "is-success"
    else
      "is-info"
    end
  end

  def truncate_string(string, limit = TRUNCATE_LIMIT)
    string.truncate(limit)
  end

  def facebook_url(handle)
    "https://www.facebook.com/#{handle}"
  end

  def instagram_url(handle)
    "https://instagram.com/#{handle}"
  end

  def linkedin_url(handle)
    "https://www.linkedin.com/in/#{handle}"
  end

  def twitter_url(handle)
    "http://twitter.com/#{handle}"
  end
end
