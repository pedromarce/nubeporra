class FootballscoreapiController < ApplicationController


  def matchsday
    api = Footballscoreapi.new
    @games = api.matchsday(params[:date]).parsed_response['matches']

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end
end
