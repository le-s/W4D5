require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'should render the new user template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #show' do
    it 'should render the show user template' do
      user = User.create(username: 'bob', password: '123456')
      get :show, params: {id: user.id}
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'logs in the user' do
        post :create, params: { user: { username: 'bob', password: '123456'} }
        user = User.find_by(username: 'bob')
        expect(session[:session_token]).to eq(user.session_token)
      end

      it 're-directs the user to the user page' do
        post :create, params: { user: { username: 'bob', password: '123456'} }
        user = User.find_by(username: 'bob')
        expect(response).to redirect_to(user_url(user))
      end
    end

    context 'with invalid params' do
      it 'returns the user to the sign in page' do
        post :create, params: { user: { username: 'bob', password: ''} }
        expect(response).to redirect_to(new_user_url)
        expect(flash[:errors]).not_to be_empty
      end
    end
  end
end
