class BetsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /bets
  # GET /bets.json
  def index
    @game = Game.find(params[:game_id])
    @bets = Bet.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /bets/1
  # GET /bets/1.json
  def show
    @bet = Bet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /bets/new
  # GET /bets/new.json
  def new
    @game = Game.find(params[:game_id])
    @bet = Bet.new
    @bet.game = @game

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /bets/1/edit
  def edit
    @game = Game.find(params[:game_id])
    @bet = Bet.find(params[:id])
  end

  # POST /bets
  # POST /bets.json
  def create
    @game = Game.find(params[:game_id])
    @bet = Bet.new(params[:bet])
    @bet.game = @game
    @bet.user = current_user

    respond_to do |format|
      if @bet.save
        format.html { redirect_to home_path, notice: 'Bet was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /bets/1
  # PUT /bets/1.json
  def update
    @bet = Bet.find(params[:id])

    respond_to do |format|
      if @bet.update_attributes(params[:bet])
        format.html { redirect_to home_path, notice: 'Bet was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /bets/1
  # DELETE /bets/1.json
  def destroy
    @bet = Bet.find(params[:id])
    @bet.destroy

    respond_to do |format|
      format.html { redirect_to bets_url }
    end
  end
end
