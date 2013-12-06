class ScoreapisController < ApplicationController

  
  def football
    api = Scoreapi.new
    time = Time.now()
    games = api.football(time.strftime('%Y-%m-%d'))
    @games = games.parsed_response['matches'] if games.parsed_response['matches']

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def nba
    api = Scoreapi.new
    @games = []
    games = api.nba(params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

end
