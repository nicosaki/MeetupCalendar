class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  # before_action :require_login
  ZIP_CODE = "98104"
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    if current_user.nil?
      flash[:error] = "You must be logged in to view this section"
      redirect_to root_path
    end
  end

  def retrieve_groups(topics) #topics = collection of topic ids
    groups = []
    topics.each do |topic|
      results = RMeetup::Client.fetch(:groups, {topic_id: topic, :zip => ZIP_CODE})
      groups << results
    end
    return groups #return groups
  end

  def retrieve_events(categories) #categories = collection of group ids
    # Event.all.destroy
    events = []
    categories.each do |category|
      results = RMeetup::Client.fetch(:events,{:zip => ZIP_CODE, group_id: category})
      results.each do |event|
        meetup = Event.find_by(url: event.event_url)
        if meetup
          if meetup.updated_at < Date.today
            Event.update(start_time: event.time, rsvps: event.rsvpcount, name: event.name)
          end
        else
          Event.create(start_time: event.time, rsvps: event.rsvpcount, group: category, url: event.event_url, name: event.name)
        end
      end
      results = {"#{category}" => results}
      events << results
    end
    return events
  end

  def fetch_group(group_number)
    results = RMeetup::Client.fetch(:groups, {group_id: group_number, zip: ZIP_CODE})
    return results[0]
  end


end
