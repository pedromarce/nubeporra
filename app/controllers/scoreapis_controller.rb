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
    if !params[:realDate]
      @realDate = Time.now()
      @offset = 0
    else 
      @realDate = Date.new(params[:realDate][:year].to_i,params[:realDate][:month].to_i,params[:realDate][:day].to_i)
      @offset = (@realDate - Date.today).to_i
    end
    games = api_nba('season/scoreScheduleByDate', 'gameDateOffset=' + @offset.to_s)
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
  end

  def nba_game(gameId)
    api_nba('game/boxscore','gameId=' + gameId.to_s).parsed_response['BoxScore']['Game']
  end

  def football_game(gameId)
    api_football('match','id=' + gameId.to_s).parsed_response
  end

  def nba_edit
    @games = []
    games = api_nba('season/scoreScheduleByDate', 'gameDateOffset=' + params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
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
        if game.typescore == "Futbol"
          logger.debug 'Externalid'
          data = football_game(game.externalid)
          if data['status'].to_i > -1
            game.score1 = data['local_goals']
            game.score2 = data['visitor_goals']
          end
          if data['status'].to_i == 1
            game.closed = true
          end
        end
        if game.typescore == "Basquet"
          logger.debug 'Externalid'
          data = nba_game(game.externalid)
          if data['status'].to_i > 1
            game.score1 = data['AwayTeam']['Score']['awayScore'].to_i - data['HomeTeam']['Score']['homeScore']
          end
          if data['status'].to_i == 3
            game.closed = true
          end
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

  def api_nba(req, param)
    HTTParty.get("http://mi.nba.com/statsm/feeds/#{req}.xhtml?tz=GMT0&dst=1&locale=en&#{param}&countryCode=GB") 
  end


end
