module ApplicationHelper
  def stalker_username(stalker_id)
    Stalker.find(stalker_id).username
  end
end
