require_relative '../rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  describe 'When valid/invalid params provided' do
    email = Faker::Internet.email
    it 'should create a new user' do
      user = User.create(name: 'Test User', email: email, password: 'password1234', password_confirmation: 'password1234')
      expect(user).to be_valid
      duplicated_user = User.create(name: 'Test User', email: email, password: 'password1234', password_confirmation: 'password1234')
      expect(duplicated_user).not_to be_valid
    end
  end

  describe 'When invalid params are provided' do
    it 'should not be valid without a name' do
      user = User.new(email: 'test@mail.com', password: 'password1234', password_confirmation: 'password1234')
      expect(user).not_to be_valid
    end

    it 'should not be valid without an email' do
      user = User.new(name: 'Test User', password: 'password1234', password_confirmation: 'password1234')
      expect(user).not_to be_valid
    end

    it 'should not be valid with an invalid email' do
      user = User.new(name: 'Test User', email: 'asdf', password: 'password1234', password_confirmation: 'password1234')
      expect(user).not_to be_valid
    end
  end
end