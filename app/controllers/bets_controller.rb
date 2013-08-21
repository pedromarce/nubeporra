class BetsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :gameClosed?, :only => [:new, :create, :update, :edit]

  # GET /bets
  # GET /bets.json
  def index
    @game = Game.find(params[:game_id])
    @bets = @game.bets

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /bets/1
  # GET /bets/1.json
  def show
    redirect_to game_bets_path, :game_id => params[:game_id]
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
        format.html { redirect_to home_path, notice: 'La teva aposta esta registrada.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /bets/1
  # PUT /bets/1.json
  def update
    @game = Game.find(params[:game_id])
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

  private

  def gameClosed?

    @game = Game.find(params[:game_id])

    if @game.closeTime.past? 
      redirect_to game_bets_path, :game_id => params[:game_id], notice: 'El partit ja esta tancat.'
    end

  end

end
