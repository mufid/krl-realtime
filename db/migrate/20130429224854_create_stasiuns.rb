class CreateStasiuns < ActiveRecord::Migration
  def change
    create_table :stasiuns do |t|
      t.string :kode
      t.string :nama
      t.column "lat", :decimal, :precision => 15, :scale => 10
      t.column "lng", :decimal, :precision => 15, :scale => 10

      t.timestamps
    end
    
    add_index :stasiuns, :kode
    add_index :stasiuns, :nama
    add_index :stasiuns, :lat
    add_index :stasiuns, :lng

    create_table :status_berhenti do |t|
      t.references :stasiuns
      t.integer :stasiun_tujuan
      t.datetime :waktu
      t.integer :no_ka
      
    end

    add_index :status_berhenti, :stasiuns_id
    add_index :status_berhenti, :waktu

  end
end
