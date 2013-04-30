class CreateStasiuns < ActiveRecord::Migration
  def change
    create_table :stasiuns do |t|
      t.string :kode
      t.column "lat", :decimal, :precision => 15, :scale => 10
      t.column "lng", :decimal, :precision => 15, :scale => 10
      t.timestamps
    end
    create_table :status_berhenti do |t|
      t.references :stasiuns
      t.integer :stasiun_tujuan
      t.datetime :waktu
      t.integer :no_ka
    end
  end
end
