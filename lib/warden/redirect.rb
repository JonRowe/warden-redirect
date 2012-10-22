module Warden
  class Redirect
    def initialize(location,status=302,headers={})
      @location, @status, @headers = location, status, headers
    end

    def [] key
      rack[key]
    end

    def status;  @status; end
    def headers; @headers.merge({ "Content-Type" => "text/html", "Location" => @location }); end
    def body;    "<html><body>You are being redirected to <a href='#{@location}'>#{@location}</a></body></html>"; end

    def rack
      [status,headers,[body]]
    end
    alias :to_ary :rack
    alias :to_a   :rack

    def kind_of?(type)
      type == Array || super
    end
  end
end 
