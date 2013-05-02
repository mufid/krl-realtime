scheduler = Rufus::Scheduler.start_new

# Jobs for retrieving data, put it into db
scheduler.every '3s', :allow_overlapping => false do
  next
  
  # puts 'Scheduler running'
  # Get secret first
  init_uri = 'http://infoka.krl.co.id/to/jak'
  initial = HTTParty.get(init_uri)
  
  next if initial.response.code != '200'
  
  secret_cookie = initial.headers['set-cookie'].split(";").first
  # I dont have any idea with this
  secret_uri = 'http://infoka.krl.co.id/XwNURRRXXFcABg0ZEWNWBQNBVRNTW0JXXgwKCRMBREpBA14FBwFJS0ZQTBNcSwpEWVxBCRt4dyhKVwFXVAcOCAQBCDoxZWJlODFiZA=='
  
  result = HTTParty.post(secret_uri, :headers => {
    "User-Agent" => "krlrealtimecrawler",
    "Referer" => init_uri,
    "Cookie" => secret_cookie
  });
  
  next if result.response.code != '200'
  
  sesuatu = JSON.parse(result)
  
  # Process the data
  #puts "--"
  sesuatu['aaData'].each do |column|
    noKereta = column[0]
    # Process only CL
    next if column[2] != "CL"
    # Process only if berhenti
    status_kereta = column[3].split(" ")[0]
    
    posisi = column[3].split(" ")[1]
    
    dari_kode, tujuan = column[1].split("-")
    next if tujuan != "JAKARTAKOTA"
    
    kodejak = Stasiun.find_by_kode("JAK").id
    s = Status_berhenti.new
    s.no_ka = noKereta
    s.waktu = Time.now
    s.ber   = (status_kereta.downcase == 'ber')
    s.nama_stasiun = posisi
    s.stasiun_tujuan = kodejak
    puts "Try to save"
    puts s
    s.save
    #puts "#{noKereta} ada di #{posisi} berangkat dari #{dari}"
  end
  
end