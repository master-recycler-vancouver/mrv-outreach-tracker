module OutreachEventHelper
  def collaborator_list(outreach_event)
    outreach_event.collaborators.map(&:full_name).join(", ")
  end
end
