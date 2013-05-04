class StasiunsController < ApplicationController
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

end
