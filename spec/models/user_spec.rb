require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    # validation examples here
    before do
      @user = User.new(
        first_name: "Test",
        last_name: "User",
        email: "test@example.com",
        password: "securepass",
        password_confirmation: "securepass"
      )
    end

    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end

    it 'is not valid without a password' do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to_not be_valid
      puts @user.errors.full_messages
    end

    it 'is not valid if password and password_confirmation do not match' do
      @user.password_confirmation = "wrong"
      expect(@user).to_not be_valid
      puts @user.errors.full_messages
    end

    it 'is not valid without a first name' do
      @user.first_name = nil
      expect(@user).to_not be_valid
    end

    it 'is not valid without a last name' do
      @user.last_name = nil
      expect(@user).to_not be_valid
    end

    it 'is not valid without an email' do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it 'is not valid with a duplicate email (case insensitive)' do
      @user.save
      user2 = User.new(
        first_name: "Test2",
        last_name: "User2",
        email: "TEST@example.com",
        password: "securepass",
        password_confirmation: "securepass"
      )
      expect(user2).to_not be_valid
      puts user2.errors.full_messages
    end

    it 'is not valid if the password is too short' do
      @user.password = "12"
      @user.password_confirmation = "12"
      expect(@user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    before do
      @user = User.create!(
        first_name: "Test",
        last_name: "User",
        email: "test@example.com",
        password: "securepass",
        password_confirmation: "securepass"
      )
    end

    it 'authenticates with valid credentials' do
      result = User.authenticate_with_credentials("test@example.com", "securepass")
      expect(result).to eq(@user)
    end

    it 'fails authentication with incorrect password' do
      result = User.authenticate_with_credentials("test@example.com", "wrongpass")
      expect(result).to be_nil
    end

    it 'authenticates with spaces around email' do
      result = User.authenticate_with_credentials("  test@example.com  ", "securepass")
      expect(result).to eq(@user)
    end

    it 'authenticates with different email casing' do
      result = User.authenticate_with_credentials("TEST@EXAMPLE.COM", "securepass")
      expect(result).to eq(@user)
    end
  end

end
