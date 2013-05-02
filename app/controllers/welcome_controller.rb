class WelcomeController < ApplicationController
  # GET /
  def index
    @status_berhenti = Status_berhenti.limit(20).order("waktu DESC")
    @status_berhenti_count = Status_berhenti.count
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
