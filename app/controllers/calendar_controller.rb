class CalendarController < ApplicationController
  skip_before_action :require_login, only: [:by_topic, :by_group]

  def show
    #@event = HTTParty.get(specific_event)
    @user = current_user
    render :show
  end

  def by_topic
    @sort_by = "topic"
    @categories = params[:topics]
    #@user_events = HTTP.get(meetups for individual user)
    render :selection_page
  end

  def by_group
    @sort_by = "group"
    @categories = params[:groups]
    @selected = params[:selected]
    #@user_events = HTTP.get(meetups for individual user)
    render :selection_page
  end

  def topics
    @sort_by = "topic"
    @categories = params[:topics]
    @selected = params[:selected]
    render :calendar
  end

  def groups
    @sort_by = "topic"
    @categories = params[:groups]
    @selected = params[:selected]
    render :calendar
  end

end
