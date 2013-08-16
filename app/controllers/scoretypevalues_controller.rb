class ScoretypevaluesController < ApplicationController
  # GET /scoretypevalues
  # GET /scoretypevalues.json
  def index
    @scoretypevalues = Scoretypevalue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @scoretypevalues }
    end
  end

  # GET /scoretypevalues/1
  # GET /scoretypevalues/1.json
  def show
    @scoretypevalue = Scoretypevalue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @scoretypevalue }
    end
  end

  # GET /scoretypevalues/new
  # GET /scoretypevalues/new.json
  def new
    @scoretypevalue = Scoretypevalue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @scoretypevalue }
    end
  end

  # GET /scoretypevalues/1/edit
  def edit
    @scoretypevalue = Scoretypevalue.find(params[:id])
  end

  # POST /scoretypevalues
  # POST /scoretypevalues.json
  def create
    @scoretypevalue = Scoretypevalue.new(params[:scoretypevalue])

    respond_to do |format|
      if @scoretypevalue.save
        format.html { redirect_to @scoretypevalue, notice: 'Scoretypevalue was successfully created.' }
        format.json { render json: @scoretypevalue, status: :created, location: @scoretypevalue }
      else
        format.html { render action: "new" }
        format.json { render json: @scoretypevalue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /scoretypevalues/1
  # PUT /scoretypevalues/1.json
  def update
    @scoretypevalue = Scoretypevalue.find(params[:id])

    respond_to do |format|
      if @scoretypevalue.update_attributes(params[:scoretypevalue])
        format.html { redirect_to @scoretypevalue, notice: 'Scoretypevalue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @scoretypevalue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scoretypevalues/1
  # DELETE /scoretypevalues/1.json
  def destroy
    @scoretypevalue = Scoretypevalue.find(params[:id])
    @scoretypevalue.destroy

    respond_to do |format|
      format.html { redirect_to scoretypevalues_url }
      format.json { head :no_content }
    end
  end
end
