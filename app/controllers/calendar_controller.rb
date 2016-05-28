class CalendarController < ApplicationController
  def by_topic
    @sort_by = "topic"
    @categories = params[:topics]
    #@user_events = HTTP.get(meetups for individual user)
  end

  get '/topics' => 'calendar#by_topic', as: 'topics'
  get '/groups' => 'calendar#by_group', as: 'groups'

  get '/calendar/topics' => 'calendar#topics', as: 'topics_calendar' #index
  get '/calendar/groups' => 'calendar#groups', as: 'groups_calendar' #index
  get '/calendar/:id/event/:user_id' => 'calendar#show', as: 'show_event'
  post '/calendar/:id/event/:user_id' => 'calendar#show'
end
