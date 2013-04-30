class WelcomeController < ApplicationController
  # GET /
  def index
    # Get secret first
    init_uri = 'http://infoka.krl.co.id/to/jak'
    initial = HTTParty.get(init_uri)
    secret_cookie = initial.headers['set-cookie'].split(";").first
    # I dont have any idea with this
    secret_uri = 'http://infoka.krl.co.id/XwNURRRXXFcABg0ZEWNWBQNBVRNTW0JXXgwKCRMBREpBA14FBwFJS0ZQTBNcSwpEWVxBCRt4dyhKVwFXVAcOCAQBCDoxZWJlODFiZA=='
    @sesuatu = HTTParty.post(secret_uri, :headers => {
      "User-Agent" => "krlrealtimecrawler",
      "Referer" => init_uri,
      "Cookie" => secret_cookie
    })
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
