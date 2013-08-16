class ScoretypesController < ApplicationController
  # GET /scoretypes
  # GET /scoretypes.json
  def index
    @scoretypes = Scoretype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scoretypes }
    end
  end

  # GET /scoretypes/1
  # GET /scoretypes/1.json
  def show
    @scoretype = Scoretype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scoretype }
    end
  end

  # GET /scoretypes/new
  # GET /scoretypes/new.json
  def new
    @scoretype = Scoretype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scoretype }
    end
  end

  # GET /scoretypes/1/edit
  def edit
    @scoretype = Scoretype.find(params[:id])
  end

  # POST /scoretypes
  # POST /scoretypes.json
  def create
    @scoretype = Scoretype.new(params[:scoretype])

    respond_to do |format|
      if @scoretype.save
        format.html { redirect_to @scoretype, notice: 'Scoretype was successfully created.' }
        format.json { render json: @scoretype, status: :created, location: @scoretype }
      else
        format.html { render action: "new" }
        format.json { render json: @scoretype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scoretypes/1
  # PUT /scoretypes/1.json
  def update
    @scoretype = Scoretype.find(params[:id])

    respond_to do |format|
      if @scoretype.update_attributes(params[:scoretype])
        format.html { redirect_to @scoretype, notice: 'Scoretype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scoretype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scoretypes/1
  # DELETE /scoretypes/1.json
  def destroy
    @scoretype = Scoretype.find(params[:id])
    @scoretype.destroy

    respond_to do |format|
      format.html { redirect_to scoretypes_url }
      format.json { head :no_content }
    end
  end
end
