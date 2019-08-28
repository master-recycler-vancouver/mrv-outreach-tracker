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

  def truncate_string(string, limit = TRUNCATE_LIMIT)
    string.truncate(limit)
  end
end
