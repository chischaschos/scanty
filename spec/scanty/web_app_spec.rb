require 'base'

describe Scanty::WebApp do

  include Rack::Test::Methods

  def app
    Scanty::WebApp
  end
  describe 'ping endpoints' do
    context 'public' do
      it '/past' do
        get '/past'
        expect(last_response).to be_ok
      end

      it '/past/:year/:month/:day/:slug/' do
        create :post
        get '/past/2015/12/07/whatever/'
        expect(last_response).to be_ok
      end

      it '/past/:year/:month/:day/:slug' do
        get '/past/2015/12/07/whatever'
        expect(last_response.status).to eq 301
      end

      xit '/feed' do
        get '/feed'
        expect(last_response).to be_ok
      end

      it '/rss' do
        get '/rss'
        expect(last_response.status).to eq 301
      end


      it '/about' do
        get '/about'
        expect(last_response).to be_ok
      end
    end

    context 'authenticated' do
      xit '/past/:year/:month/:day/:slug/edit' do
        get '/past/:year/:month/:day/:slug/edit'
      end

      xit '/past/:year/:month/:day/:slug/' do
        post '/past/:year/:month/:day/:slug/'
      end

    end
  end

end
