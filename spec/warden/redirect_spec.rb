require 'warden/redirect'

shared_examples_for 'warden redirect' do |opts|

  #rack status
  its([0])      { should == opts[:status] }
  its(:status)  { should == opts[:status] }
  its(:first)   { should == opts[:status] }

  #rack headers
  its([1])      { should == opts[:headers] }
  its(:headers) { should == opts[:headers] }

  #rack body
  specify { subject[2].first.should include 'You are being redirected' }

  #warden compat
  it { should be_a Array }
  specify do
    status, headers, body = subject
    status.should  == opts[:status]
    headers.should == opts[:headers]
    body.should    == subject[2]
  end
end

describe 'redirecting to a specific location' do
  subject { Warden::Redirect.new '/location' }

  it_should_behave_like 'warden redirect',
    :status  => 302,
    :headers => { "Location" => "/location", "Content-Type" => "text/html" }
end

describe 'redirecting to a specific location with a status' do
  subject { Warden::Redirect.new '/location', 301 }

  it_should_behave_like 'warden redirect',
    :status  => 301,
    :headers => { "Location" => "/location", "Content-Type" => "text/html" }
end

describe 'redirecting to a specific location with a status and headers' do
  subject { Warden::Redirect.new '/location', 301, "X-SHALL-NOT-PASS" => true  }

  it_should_behave_like 'warden redirect',
    :status  => 301,
    :headers => { "Location" => "/location", "Content-Type" => "text/html", "X-SHALL-NOT-PASS" => true }
end

describe 'warden compatilbity' do
  subject      { throw :warden, Warden::Redirect.new('/location') }
  let(:result) { catch(:warden) { subject } }

  specify do
    case result
    when Array
      true
    else
      fail
    end
  end

end
