class ScoreapisController < ApplicationController
  include HTTParty

  def football
    time = Time.now()
    games = api_football(time.strftime('%Y-%m-%d'))
    @games = games.parsed_response['matches'] if games.parsed_response['matches']

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def footballnext
    time = Time.parse(params[:date]) + 1.days
    games = api_football(time.strftime('%Y-%m-%d'))
    @games = games.parsed_response['matches'] if games.parsed_response['matches']

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def footballprev
    time = Time.parse(params[:date]) - 1.days
    games = api_football(time.strftime('%Y-%m-%d'))
    @games = games.parsed_response['matches'] if games.parsed_response['matches']

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def nba
    @games = []
    games = api_nba(params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def nbanext
    @games = []
    games = api_nba(params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def nbaprev
    @games = []
    games = api_nba(params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  private

   def api_football(date)
    base_uri = 'http://www.resultados-futbol.com/scripts/api/api.php'
    key_param = '5cdb0947a37e178f340b78576e90d058'
    format_param = 'json' 
    HTTParty.get("#{base_uri}?key=#{key_param}&format=#{format_param}&req=matchsday&top=true&date=#{date}") 
  end

  def api_nba(date)
    base_uri = 'http://mi.nba.com/statsm/feeds/season/scoreScheduleByDate.xhtml?tz=GMT0&dst=1&locale=en&gameDateOffset='
    suffix = '&countryCode=GB' 
    HTTParty.get("#{base_uri}#{date}#{suffix}") 
  end


end
