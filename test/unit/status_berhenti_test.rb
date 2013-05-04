require 'test_helper'

# Test for
class StatusBerhentiTest < ActiveSupport::TestCase
  # Please consult to fixture for this unit test
  test "should show 2 trains stop at bogor (from fixture)" do
    id_bogor = stasiuns(:bogor).id
    data = Status_berhenti.find_all_by_stasiun_id(id_bogor)
    assert data.count == 2
  end
  
  # This is happened when situation is:
  #   AT BOGOR
  #     KERETA1 7.45
  #     KERETA1 7.47
  #     KERETA2 7.49
  # AFTER NEW DATA RETRIEVED
  #   AT BOGOR
  #     KERETA1 7.45 <-- The oldest one dibiarin
  #     KERETA1 7.52 <-- The latest one deleted, replaced with this
  #     KERETA2 7.49  
  test "should show 3 train stop status at bogor" do
    no_ka = status_berhenti(:keretabogor2).no_ka

    stasiun_bogor = stasiuns(:bogor).nama
    stasiun_bogor_id = stasiuns(:bogor).id
    stasiun_jakarta_id = stasiuns(:jakarta).id
    
    s = Status_berhenti.new
    s.no_ka = no_ka
    s.waktu = 10.seconds.ago
    s.nama_stasiun = stasiun_bogor
    s.ber   = false
    s.stasiun_tujuan = stasiun_jakarta_id
    s.save

    s = Status_berhenti.new
    s.no_ka = no_ka
    s.waktu = 5.seconds.ago
    s.ber   = false
    s.nama_stasiun = stasiun_bogor
    s.stasiun_tujuan = stasiun_jakarta_id
    s.save

    s = Status_berhenti.new
    s.no_ka = no_ka
    s.waktu = 3.seconds.ago
    s.ber   = false
    s.nama_stasiun = stasiun_bogor
    s.stasiun_tujuan = stasiun_jakarta_id
    s.save
    
    c = Status_berhenti.where(:stasiun_id => stasiun_bogor_id, :no_ka => no_ka).count
    assert c == 2, "Should only show 2 status berhenti instead of #{c}"
           
    s = Status_berhenti.new
    s.no_ka = no_ka
    s.waktu = 1.seconds.ago
    s.ber   = false
    s.nama_stasiun = stasiun_bogor
    s.stasiun_tujuan = stasiun_jakarta_id
    s.save
    
    assert Status_berhenti.where(:stasiun_id => stasiun_bogor_id, :no_ka => no_ka).count == 2,
           "Should only show 2 status berhenti, even after next insert"

  end
  test "should auto update when DI missed" do
    no_ka = status_berhenti(:keretabogor2).no_ka
    cbt = stasiuns(:cilebut).nama
    cbt_id = stasiuns(:cilebut).id
    bjg = stasiuns(:bojonggede).nama
    bjg_id = stasiuns(:bojonggede).id
    jkt_id = stasiuns(:jakarta).id
    
    z = Status_berhenti.new
    z.no_ka = no_ka
    waktu = 20.seconds.ago
    z.waktu = waktu
    z.ber   = true
    z.nama_stasiun = cbt
    z.stasiun_tujuan = jkt_id
    z.save
    
    assert !Status_berhenti.find_by_stasiun_id(
           cbt_id, :conditions => [
           "no_ka = ?", no_ka ], :order => "waktu DESC").nil?,
           "Should exist entry in Cilebut"

    s = Status_berhenti.new
    s.no_ka = no_ka
    s.waktu = 5.seconds.ago
    s.ber   = true
    s.nama_stasiun = cbt
    s.stasiun_tujuan = jkt_id
    s.save

    # WARN: Test is not yet contain "not changed", only
    # test "only show 1 in cilebut"
    assert Status_berhenti.find_all_by_stasiun_id(
           cbt_id, :conditions => [
           "no_ka = ?", no_ka ], :order => "waktu DESC").count == 1,
           "Should only show 1 in cilebut after BER add request"
    waktu_db = Status_berhenti.find_by_id(z.id).waktu
    assert waktu_db == waktu,
           "Should not change the entry. Read from db got #{waktu_db}. Previously got #{waktu}"
  end
end
