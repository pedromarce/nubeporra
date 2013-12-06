class NbascoreapiController < ApplicationController


  def matchsday
    api = Nbascoreapi.new
    @games = []
    games = api.matchsday(params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end
end
