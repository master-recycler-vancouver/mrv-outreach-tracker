module ApplicationHelper

  def navbar_user_class
    case current_user.role
    when "admin"
      "navbar--admin"
    else
      "navbar--student"
    end
  end
end
