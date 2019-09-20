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
end
