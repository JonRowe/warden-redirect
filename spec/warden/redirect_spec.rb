require 'warden/redirect'

shared_examples_for 'warden redirect' do |opts|

  #rack status
  specify { expect(subject[0]).to      eq opts[:status] }
  specify { expect(subject.status).to  eq opts[:status] }
  specify { expect(subject.first).to   eq opts[:status] }

  #rack headers
  specify { expect(subject[1]).to      eq opts[:headers] }
  specify { expect(subject.headers).to eq opts[:headers] }

  #rack body
  specify { expect(subject[2].first).to include 'You are being redirected' }

  #warden compat
  it { is_expected.to be_a Array }
  specify do
    status, headers, body = subject
    expect(status).to  eq opts[:status]
    expect(headers).to eq opts[:headers]
    expect(body).to    eq subject[2]
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
