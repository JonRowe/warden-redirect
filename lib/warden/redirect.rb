module Warden
  class Redirect < Array
    def initialize(location,status=302,headers={})
      redirect_headers = headers.merge({ "Content-Type" => "text/html", "Location" => location })
      body = "<html><body>You are being redirected to <a href='#{location}'>#{location}</a></body></html>"
      super [status,redirect_headers,[body]]
    end

    def status;  self[0]; end
    def headers; self[1]; end
    def body;    self[2]; end
  end
end
