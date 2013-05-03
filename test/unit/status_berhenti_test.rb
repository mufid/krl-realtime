require 'test_helper'

# Test for
class StatusBerhentiTest < ActiveSupport::TestCase
  # Please consult to fixture
  test "should show 2 trains stop at bogor" do
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
  #     KERETA1 7.45
  #     KERETA1 7.52
  #     KERETA2 7.49  
  test "should show 3 train stop status at bogor" do
    no_ka = status_berhenti(:keretabogor2).no_ka
    assert true
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
    assert true
    assert Status_berhenti.where(:stasiun_id => stasiun_bogor_id).count == 3,
           "Should only show 3 status"
  end
end
