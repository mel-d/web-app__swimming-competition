require "pry"

MyApp.get "/events" do
  @events = Event.all
  erb :"main/events"
end

MyApp.get "/add/event_form_add" do
  erb :"main/add/event_form_add"
end

MyApp.post "/event_added" do
  x = Event.new
  x.gender = params[:gender]
  x.distance = params[:race_distance]
  x.style_id = params[:style_id]
  x.lock = false
  x.save
  erb :"main/add/event_added"
end

MyApp.get "/competitors_by_event/:blah" do
  @event_comp_ids = []
  @competitor_objects = []
  @event = Event.find_by_id(params[:blah])
  @comps_in_event = Result.where({"event_id" => params[:blah]})
  @comps_in_event.each do |c|
    @event_comp_ids << c.competitor_id
  end
  @event_comp_ids.each do |i|
    @competitor_objects << Competitor.find_by_id(i)
  end
  erb :"main/competitors_by_event_result"
end

MyApp.get "/delete/event_deleted/:dogfood" do
  @event = Event.find_by_id(params[:dogfood])
  @lock_check = @event.lock
  if @lock_check == true
    erb :"main/locked_error_page"
  else
    @event.delete
    erb :"main/delete/event_deleted"
  end
end

MyApp.get "/update/event_update_form/:popsicle" do
  @event = Event.find_by_id(params[:popsicle])
  @lock_check = @event.lock
  if @lock_check == true
    erb :"main/locked_error_page"
  else
    erb :"main/update/event_update_form"
  end
end

MyApp.post "/update/event_updated/:stopsign" do
  @event = Event.find_by_id(params[:stopsign])
  @event.gender = params[:gender]
  @event.distance = params[:race_distance]
  @event.style_id = params[:style_id]
  @event.save
  erb :"main/update/event_updated"
end

MyApp.get "/event_locked/:id" do
  @event = Event.find_by_id(params[:id])
  @event.lock = true
  @event.save
  erb :"main/event_locked"
end