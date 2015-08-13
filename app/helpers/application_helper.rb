module ApplicationHelper
  def display_pacific_time(time_date_object)
    # 5:40PM Saturday, June 7th, 2015 (PST)
    time_in_PST = time_date_object.in_time_zone("Pacific Time (US & Canada)")
    formatted_time = time_in_PST.strftime("%l:%M%p %A, %B %e, %Y (%Z)")
  end
end
