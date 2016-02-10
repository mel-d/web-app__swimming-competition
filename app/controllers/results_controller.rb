MyApp.get "/results" do
  erb :"main/results"
end

MyApp.get "/result_added" do
  x = Result.new
  @results = Result.all
  @competitors = Competitor.all
  @events = Event.all
  x.competitor_id = params[:competitor_id]
  x.event_id = params [:event_id]
  x.final_time = params[:final_time]
  x.save
  erb :"main/result_added"
end