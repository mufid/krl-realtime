class StasiunsController # < ApplicationController
                         # OBSOLOTE
  # GET /stasiuns
  # GET /stasiuns.json
  def index
    @stasiuns = Stasiun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stasiuns }
    end
  end

  # GET /stasiuns/1
  # GET /stasiuns/1.json
  def show
    @stasiun = Stasiun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stasiun }
    end
  end

  # GET /stasiuns/new
  # GET /stasiuns/new.json
  def new
    @stasiun = Stasiun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stasiun }
    end
  end

  # GET /stasiuns/1/edit
  def edit
    @stasiun = Stasiun.find(params[:id])
  end

  # POST /stasiuns
  # POST /stasiuns.json
  def create
    @stasiun = Stasiun.new(params[:stasiun])

    respond_to do |format|
      if @stasiun.save
        format.html { redirect_to @stasiun, notice: 'Stasiun was successfully created.' }
        format.json { render json: @stasiun, status: :created, location: @stasiun }
      else
        format.html { render action: "new" }
        format.json { render json: @stasiun.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stasiuns/1
  # PUT /stasiuns/1.json
  def update
    @stasiun = Stasiun.find(params[:id])

    respond_to do |format|
      if @stasiun.update_attributes(params[:stasiun])
        format.html { redirect_to @stasiun, notice: 'Stasiun was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stasiun.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stasiuns/1
  # DELETE /stasiuns/1.json
  def destroy
    @stasiun = Stasiun.find(params[:id])
    @stasiun.destroy

    respond_to do |format|
      format.html { redirect_to stasiuns_url }
      format.json { head :no_content }
    end
  end
end
