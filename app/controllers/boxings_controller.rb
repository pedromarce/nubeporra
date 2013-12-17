class BoxingsController < ApplicationController
  # GET /boxings
  # GET /boxings.json
  def index
    @boxings = Boxing.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @boxings }
    end
  end

  def standing
    @boxing = Boxing.find(params[:id])
    @standings = User.all.sort_by { |user| (@boxing.numpoints user) * -1}
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boxing }
    end
  end

  def betting
    @boxing = Boxing.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boxing }
    end
  end

  # GET /boxings/1
  # GET /boxings/1.json
  def show
    @boxing = Boxing.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @boxing }
    end
  end

  # GET /boxings/new
  # GET /boxings/new.json
  def new
    @boxing = Boxing.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @boxing }
    end
  end

  # GET /boxings/1/edit
  def edit
    @boxing = Boxing.find(params[:id])
  end

  # POST /boxings
  # POST /boxings.json
  def create
    @boxing = Boxing.new(params[:boxing])

    respond_to do |format|
      if @boxing.save
        format.html { redirect_to @boxing, notice: 'Boxing was successfully created.' }
        format.json { render json: @boxing, status: :created, location: @boxing }
      else
        format.html { render action: "new" }
        format.json { render json: @boxing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /boxings/1
  # PUT /boxings/1.json
  def update
    @boxing = Boxing.find(params[:id])

    respond_to do |format|
      if @boxing.update_attributes(params[:boxing])
        format.html { redirect_to @boxing, notice: 'Boxing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @boxing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxings/1
  # DELETE /boxings/1.json
  def destroy
    @boxing = Boxing.find(params[:id])
    @boxing.destroy

    respond_to do |format|
      format.html { redirect_to boxings_url }
      format.json { head :no_content }
    end
  end

  def import
    @toCreate = params[:toCreate]
    @toCreate.each do |data|
      if data[:score1]
        game = Game.find(data[:id])
        bet = (game.userbet(current_user) ? game.userbet(current_user) : Bet.new)
        bet.user = current_user
        bet.game = game
        bet.score1 = data[:score1]
        bet.score2 = data[:score2]
        bet.score3 = data[:score3]
        bet.save
      end
    end    
    redirect_to :home
  end
end
