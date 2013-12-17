class ScoreapisController < ApplicationController
  include HTTParty
  include Nokogiri

  def football
    @games = []
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

  def acb
    @games = []
    if !params[:realDate]
      @realDate = Time.now()
    else 
      @realDate = Date.new(params[:realDate][:year].to_i,params[:realDate][:month].to_i,params[:realDate][:day].to_i)
    end
    @games = api_acb('','').select{|game| game['date'] == @realDate}
  end

  def asobal
    if !params[:realDate]
      @realDate = Time.now()
    else 
      @realDate = Date.new(params[:realDate][:year].to_i,params[:realDate][:month].to_i,params[:realDate][:day].to_i)
    end
    @date = @realDate.strftime('%Y-%m-%d')
    @games = api_asobal('','').select{|game| game['date'] == @realDate}
  end

  def futsal
    if !params[:realDate]
      @realDate = Time.now()
    else 
      @realDate = Date.new(params[:realDate][:year].to_i,params[:realDate][:month].to_i,params[:realDate][:day].to_i)
    end
    @date = @realDate.strftime('%Y-%m-%d')
    @games = api_futsal('','').select{|game| game['date'] == @realDate}
  end

  def nba_game(gameId)
    game = api_nba('game/boxscore','gameId=' + gameId.to_s)
    game.parsed_response['BoxScore']['Game'] if game
  end

  def football_game(gameId)
    api_football('match','id=' + gameId.to_s).parsed_response
  end

  def acb_edit
    @realDate = Date.parse(params[:date])
    @games = api_acb('','').select{|game| game['date'] == @realDate}
  end

  def futsal_edit
    @realDate = Date.parse(params[:date])
    @games = api_futsal('','').select{|game| game['date'] == @realDate}
  end

  def asobal_edit
    @realDate = Date.parse(params[:date])
    @games = api_asobal('','').select{|game| game['date'] == @realDate}
  end

  def acb_game(gameId)
    @games = api_acb('','').select{|game| game['id'] == gameId}[0]
  end

  def asobal_game(gameId)
    @games = api_asobal('','').select{|game| game['id'] == gameId}[0]
  end

  def futsal_game(gameId)
    @games = api_futsal('','').select{|game| game['id'] == gameId}[0]
  end

  def nba_edit
    @games = []
    games = api_nba('season/scoreScheduleByDate', 'gameDateOffset=' + params[:date])
    @games = games.parsed_response['Schedule']['League']['Game'] if games.parsed_response['Schedule']['League']['Game']
  end

  def football_edit
    @games = []
    games = api_football('matchsday', 'date=' + params[:date])
    @games = games.parsed_response['matches'] if games.parsed_response
  end

  def close_games
    gamesT = Game.arel_table
    games = Game.where(gamesT[:closed].eq(false).or(gamesT[:closed].eq(nil)))
    games.each do |game|
      if game.externalid and !game.gameTime.past?
        if game.typescore == 'Futbol'
          data = football_game(game.externalid)
          if data['status'].to_i > -1
            game.score1 = data['local_goals']
            game.score2 = data['visitor_goals']
          end
          if data['status'].to_i == 1
            game.closed = true
          end
        end
        if game.typescore == 'Futbol_Sala'
          data = futsal_game(game.externalid)
          if data['homeScore'] != ''
            game.score1 = data['homeScore'].to_i 
            game.score2 = data['awayScore'].to_i
          end
          if game.gameTime + 3.hour < DateTime.now
            game.closed = true
          end
        end
        if game.typescore == 'Handball'
          data = asobal_game(game.externalid)
          if data['homeScore'] != ''
            game.score1 = data['homeScore'].to_i - data['awayScore'].to_i
          end
          if game.gameTime + 3.hour < DateTime.now
            game.closed = true
          end
        end
        if game.typescore == 'Basquet'
          if game.externalid[0..6] == 'ELMUNDO'
            data = acb_game(game.externalid)
            if data['homeScore'] != ''
              game.score1 = data['homeScore'].to_i - data['awayScore'].to_i
            end
            if game.gameTime + 3.hour < DateTime.now
              game.closed = true
            end
          else
            if data = nba_game(game.externalid)
              if data['boxscoreStatus'].to_i > 1
                game.score1 = data['AwayTeam']['Score']['awayScore'].to_i - data['HomeTeam']['Score']['homeScore'].to_i
              end
              if data['boxscoreStatus'].to_i == 3
                game.closed = true
              end
            end 
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
    begin 
      HTTParty.get("http://mi.nba.com/statsm/feeds/#{req}.xhtml?tz=GMT0&dst=1&locale=en&#{param}&countryCode=GB") 
    rescue URI::InvalidURIError
    end
  end

  def api_acb(req, param)
    acb = Nokogiri::HTML(HTTParty.get("http://www.elmundo.es/elmundodeporte/baloncesto/acb/calendario.html").parsed_response)
    parse_el_mundo(acb)
  end

  def api_asobal(req, param)
    asobal = Nokogiri::HTML(HTTParty.get("http://www.elmundo.es/elmundodeporte/balonmano/asobal/calendario.html").parsed_response)
    parse_el_mundo(asobal)
  end

  def api_futsal(req, param)
    futsal = Nokogiri::HTML(HTTParty.get("http://www.elmundo.es/elmundodeporte/futbol/futbol-sala/calendario.html").parsed_response)
    parse_el_mundo(futsal)
  end

  def parse_el_mundo(html)
    games = []
    html.css("ul.calendario-jornadas li").each do |jornada|
      dates = jornada.css(".titulo-columna strong").text
      jornada.css("tr").each do |partido|
        game = Hash.new
        date = partido.css(".fecha span").text
        game['date'] = Date.new(dates.split('-')[0].split('.')[2].to_i, date.split('/')[1].to_i, date.split('/')[0].to_i)
        game['home'] = partido.css(".local span").text
        game['away'] = partido.css(".visitante span").text
        game['time'] = partido.css(".hora span").text
        if game['time'] == ""
          game['homeScore'] = partido.css(".marcador strong")[0].text
          game['awayScore'] = partido.css(".marcador strong")[1].text
          game['time']      = '18:00h'
        end
        game['id'] = 'ELMUNDO' + game['home'] + ' ' + game['away']
        games.push(game)
      end
    end
    return games
  end
end
