require 'warden/redirect'

describe 'redirecting to a specific location' do
  subject { Warden::Redirect.new '/location' }

  #rack status
  its([0]) { should == 302 }
  #rack headers
  its([1]) { should == { "Location" => "/location", "Content-Type" => "text/html" } }
  #rack body
  specify { subject[2].first.should include 'You are being redirected' }

  its(:headers) { should == { "Location" => "/location", "Content-Type" => "text/html" } }
  its(:status)  { should == 302 }

  #warden compat
  it { should be_a Array }
end

describe 'redirecting to a specific location with a status' do
  subject { Warden::Redirect.new '/location', 301 }

  #rack status
  its([0]) { should == 301 }
  #rack headers
  its([1]) { should == { "Location" => "/location", "Content-Type" => "text/html" } }
  #rack body
  specify { subject[2].first.should include 'You are being redirected' }

  its(:headers) { should == { "Location" => "/location", "Content-Type" => "text/html" } }
  its(:status)  { should == 301 }

  #warden compat
  it { should be_a Array }
end

describe 'redirecting to a specific location with a status and headers' do
  subject { Warden::Redirect.new '/location', 301, "X-SHALL-NOT-PASS" => true  }

  #rack status
  its([0]) { should == 301 }
  #rack headers
  its([1]) { should == { "Location" => "/location", "Content-Type" => "text/html", "X-SHALL-NOT-PASS" => true } }
  #rack body
  specify { subject[2].first.should include 'You are being redirected' }

  its(:headers) { should == { "Location" => "/location", "Content-Type" => "text/html", "X-SHALL-NOT-PASS" => true } }
  its(:status)  { should == 301 }

  #warden compat
  it { should be_a Array }
end
