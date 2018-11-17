# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'Password validation' do
    it 'Should return a user when the passwords match' do
      user = User.create!(username: 'Bob', password: 'password')
      found_user = User.find_by_credentials('Bob', 'password')
      expect(found_user).to eq(user)
    end

    it 'Should return nil when the passwords don\'t match' do
      user = User.create!(username: 'Bob', password: 'password')
      found_user = User.find_by_credentials('Bob', '')
      expect(found_user).to eq(nil)
    end
  end

  describe 'Session token validation' do
    it "should always have a session token" do
      user = User.create!(username: 'Bob', password: 'password')
      expect(user.session_token).not_to eq(nil)
    end

    it "should change the session token when reset session token is called" do
      user = User.create!(username: 'Bob', password: 'password')
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_session_token)
    end
  end

end
