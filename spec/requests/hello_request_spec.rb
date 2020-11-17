require 'rails_helper'

RSpec.describe 'Hello', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end

    it 'returns hello world!' do
      get '/'
      expect(response.body).to eq('hello')
    end
  end
end
