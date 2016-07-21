require 'warden/redirect'

RSpec.describe 'Warden::Redirect' do
  shared_examples_for 'redirecting' do |opts|
    it 'behaves like an array' do
      status, headers, body = redirect_response

      expect(redirect_response).to be_a Array
      expect(status).to eq opts[:status]
      expect(headers).to eq opts[:headers]
      expect(body).to include a_string_including 'You are being redirected'
    end

    it 'exposes status' do
      expect(redirect_response.status).to eq opts[:status]
    end

    it 'exposes headers' do
      expect(redirect_response.headers).to eq opts[:headers]
    end

    it 'exposes the body' do
      expect(redirect_response.body).to include a_string_including 'You are being redirected'
    end
  end

  describe 'redirecting to a specific location' do
    let(:redirect_response) { Warden::Redirect.new '/location' }

    it_behaves_like 'redirecting',
      :status  => 302,
      :headers => { "Location" => "/location", "Content-Type" => "text/html" }
  end

  describe 'redirecting to a specific location with a status' do
    let(:redirect_response) { Warden::Redirect.new '/location', 301 }

    it_behaves_like 'redirecting',
      :status  => 301,
      :headers => { "Location" => "/location", "Content-Type" => "text/html" }
  end

  describe 'redirecting to a specific location with a status and headers' do
    let(:redirect_response) { Warden::Redirect.new '/location', 301, "X-SHALL-NOT-PASS" => true  }

    it_behaves_like 'redirecting',
      :status  => 301,
      :headers => { "Location" => "/location", "Content-Type" => "text/html", "X-SHALL-NOT-PASS" => true }
  end

  describe 'warden compatibility' do
    let(:redirect_response) { throw :warden, Warden::Redirect.new('/location') }
    let(:result) { catch(:warden) { redirect } }

    it 'returns an array for compatibility with warden' do
      expect(
        catch(:warden) { throw :warden, Warden::Redirect.new('/location') }
      ).to be_a Array
    end
  end
end
