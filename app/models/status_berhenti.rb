class Status_berhenti < ActiveRecord::Base
  self.table_name = "status_berhenti"
  
  before_save :no_duplicate
  
  attr_accessible :stasiun_tujuan, :waktu, :no_ka, :id, :ber, :nama_stasiun
  
  belongs_to :stasiun
  #has_one :stasiun, :through => :stasiuns_id
  
  def no_duplicate
    return true unless self.new_record?
    puts "A new record."
    # Check latest data in that station
    stasiun = Stasiun.find_or_create_by_nama(self.nama_stasiun.capitalize)
    self.stasiun_id = stasiun.id
    puts "For #{@nama_stasiun}, id is #{stasiun_id}"
    
    # BER phase
    if self.ber
      terakhir = Status_berhenti.find_by_no_ka(@no_ka, :conditions => 
      ["waktu > ?", 
        1.minutes.ago], :order => "waktu DESC")
      return false if terakhir.nil?
      return false if terakhir.stasiun_id == @stasiun_id
      return true
    end

    # DI phase
    terakhir = Status_berhenti.find_all_by_stasiun_id(stasiun_id, :conditions => 
    ["waktu > ? AND stasiun_id = ? AND no_ka = ?", 
      15.minutes.ago, stasiun_id, @no_ka], :order => "waktu DESC", :limit => 2)
    return true if terakhir == nil
    return true if terakhir.count < 2
    Status_berhenti.delete(terakhir.first.id)
    puts "Deletion"
    true
  end
end