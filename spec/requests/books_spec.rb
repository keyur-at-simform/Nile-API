require 'rails_helper'

describe 'Books API', type: :request do
  describe 'GET /books' do
    before do
      FactoryBot.create(:book, title: 'Do Epic Shit', author: 'Ankur variku')
      FactoryBot.create(:book, title: 'The Alchemist', author: 'paulo cohelo')
    end
    it 'returns all books' do
      get '/api/v1/books'

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'POST /books' do
    it 'create a new book' do
      expect do
        post '/api/v1/books', params: { book: { title: 'Do Epic Shit', author: 'Ankur variku' } }
      end.to change { Book.count }.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /books/:id' do
    let!(:book) { FactoryBot.create(:book, title: 'Do Epic Shit', author: 'Ankur variku') }
    it 'delete a book' do
      expect do
        delete "/api/v1/books/#{book.id}"
      end.to change { Book.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
