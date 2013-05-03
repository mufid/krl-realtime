require 'test_helper'

# No special test for stasiun data
class StasiunTest < ActiveSupport::TestCase
  test "should show all stasiun" do
    gakada = true
    Stasiun.all.each do |row|
      Rails::logger.debug row.nama
      gakada = false
    end
    assert !gakada
  end
  test "jakarta should exist" do
    assert !Stasiun.find_by_kode("JAK").nil?
  end
  test "bogor should also exist" do
    assert !Stasiun.find_by_kode("BOO").nil?
  end
end
