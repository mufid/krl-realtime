class Status_berhenti < ActiveRecord::Base
  self.table_name = "status_berhenti"
  
  before_save :no_duplicate
  
  attr_accessible :stasiun_tujuan, :waktu, :no_ka, :id
  attr_accessor :ber, :nama_stasiun
  belongs_to :stasiun
  #has_one :stasiun, :through => :stasiuns_id
  

  
    
  def no_duplicate
    # Only run if new_record
    return true unless self.new_record?
    # Check latest data in that station
    stasiun = Stasiun.find_or_create_by_nama(self.nama_stasiun.capitalize)
    self.stasiun_id = stasiun.id
    
    # BER phase
    if self.ber
      terakhir = Status_berhenti.find_by_no_ka(self.no_ka, :conditions => 
      ["waktu > ?", 
        20.minutes.ago], :order => "waktu DESC")
      return false if terakhir.nil?
      return false if terakhir.stasiun_id == self.stasiun_id
      return true
    end

    # DI phase
    terakhir = Status_berhenti.find_all_by_stasiun_id(stasiun_id, :conditions => 
    ["waktu > ? AND no_ka = ?", 
      15.minutes.ago, self.no_ka], :order => "waktu DESC", :limit => 2)
        
    return true if terakhir == nil
    return true if terakhir.length < 2
    Status_berhenti.delete(terakhir.first.id)
    true
  end
end