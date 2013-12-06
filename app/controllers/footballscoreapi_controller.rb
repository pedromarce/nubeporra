class FootballscoreapiController < ApplicationController


  def matchsday
    api = Footballscoreapi.new
    @games = []
    games = api.matchsday(params[:date])
    @games = games.parsed_response['matches'] if games.parsed_response['matches']

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end
end
