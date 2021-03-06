class GamesController < ApplicationController
  before_filter :authenticate_user!
  # GET /games
  # GET /games.json
  def index
#    @games = Game.all
    @games = Game.order('"gameTime"').where(:gameTime => 5.days.ago..60.days.from_now)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        update_boxing_closeTime(@game)
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        update_boxing_closeTime(@game)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  def import
    @toCreate = params[:toCreate]
    @toCreate.each do |data|
      if data[:create]
        game = Game.new(params[:game])
        game.description = data[:local] + " - " + data[:visitor]
        game.externalid = data[:id]
        if game.typescore == 'Futbol'
          game.gameTime = DateTime.parse(data[:date]).change(hour: data[:hour].to_i - 1, min: data[:minute].to_i)
        elsif game.typescore == 'Basquet'
          game.gameTime = DateTime.strptime(data[:date] + data[:time],'%Y-%m-%d%I:%M %p')  
        elsif game.typescore == 'Acb'
          game.typescore = 'Basquet'
          game.gameTime = DateTime.strptime(data[:date] + data[:time],'%Y-%m-%d%H:%Mh')
          game.gameTime = game.gameTime - 1.hour  
        elsif game.typescore == 'Futbol_Sala'
          game.gameTime = DateTime.strptime(data[:date] + data[:time],'%Y-%m-%d%H:%Mh')
          game.gameTime = game.gameTime - 1.hour  
        elsif game.typescore == 'Handball'
          game.gameTime = DateTime.strptime(data[:date] + data[:time],'%Y-%m-%d%H:%Mh')
          game.gameTime = game.gameTime - 1.hour  
        end
        game.score1 = ''
        game.score2 = ''
        game.score3 = ''
        game.closeTime = game.gameTime - 15.minutes
        game.save
        update_boxing_closeTime(game)
      end  
    end
    redirect_to root_path
  end

  def update_boxing_closeTime(game)
    if game.boxing
      boxingGames = game.boxing.games.sort_by { |boxingGame| boxingGame.closeTime }
      closeTime = boxingGames[0].closeTime
      game.boxing.games.each do |boxingGame|
        boxingGame.closeTime = closeTime
        boxingGame.save
      end
    end  
  end
end
