class CalendarController < ApplicationController
  skip_before_action :require_login, only: [:by_topic, :by_group]

  def show
    #@event = HTTParty.get(specific_event)
    @user = current_user
    render :show
  end

  def by_topic
    @unique_list = []
    @sort_by = "topic"
    @categories = params[:categories]
    @results = RMeetup::Client.fetch(:topics)

    render :topic_selection
  end

  def by_group
    @unique_list = []
    @sort_by = "group"
    @topics = params[:categories]
    @groups = retrieve_groups(@topics)
    render :groups_selection
  end

  def topics #may be extraneous
    @sort_by = "topic"
    @categories = params[:categories]
    render :calendar
  end

  def groups
    @meetups = Event.all
    @sort_by = "group"
    @groups_selected = params[:categories]
    @events_by_group = retrieve_events(@groups_selected)
    @groups_selected.map do |group|
      fetch_group(group).name
    end
    render :calendar
  end

end
