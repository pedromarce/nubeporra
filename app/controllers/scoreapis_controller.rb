class ScoreapisController < ApplicationController
  include HTTParty

  def football
    if !params[:realDate]
      @realDate = Time.now()
    else 
      @realDate = Date.new(params[:realDate][:year].to_i,params[:realDate][:month].to_i,params[:realDate][:day].to_i)
    end
    @date = @realDate.strftime('%Y-%m-%d')
    games = api_football('matchsday', 'date=' + @date)
    @games = games.parsed_response['matches'] if games.parsed_response['matches']
  end

  def nba
    @games = []
    games = api_nba(params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
  end

  def football_game(game)
    api_football('match','id=' + game.to_s).parsed_response
  end

  def football_edit
    games = api_football('matchsday', 'date=' + params[:date])
    @games = games.parsed_response['matches'] if games.parsed_response['matches']
  end

  def close_games
    gamesT = Game.arel_table
    games = Game.where(gamesT[:closed].eq(false).or(gamesT[:closed].eq(nil)))
    games.each do |game|
      if game.externalid
        logger.debug 'Externalid'
        data = football_game(game.externalid)
        if data['status'].to_i > -1
          game.score1 = data['local_goals']
          game.score2 = data['visitor_goals']
        end
        if data['status'].to_i == 1
          game.closed = true
        end
        game.save
      end        
    end
  end

  private

   def api_football(req, param)
    base_uri = 'http://www.resultados-futbol.com/scripts/api/api.php'
    key_param = '5cdb0947a37e178f340b78576e90d058'
    format_param = 'json' 
    HTTParty.get("#{base_uri}?key=#{key_param}&format=#{format_param}&req=#{req}&top=true&#{param}") 
  end

  def api_nba(date)
    base_uri = 'http://mi.nba.com/statsm/feeds/season/scoreScheduleByDate.xhtml?tz=GMT0&dst=1&locale=en&gameDateOffset='
    suffix = '&countryCode=GB' 
    HTTParty.get("#{base_uri}#{date}#{suffix}") 
  end


end
