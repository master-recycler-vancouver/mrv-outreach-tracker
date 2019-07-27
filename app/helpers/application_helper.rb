module ApplicationHelper

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
end
