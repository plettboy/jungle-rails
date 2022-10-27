require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it "saves when all fields entered" do
      @user = User.new(
        first_name: "bingo",
        last_name: "bongo",
        email: "link0@yahoo.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      expect(@user).to be_valid
    end
    it "invalid password and password_confirmation fields" do
      @user = User.new(
        first_name: "bingo",
        last_name: "bongo",
        email: "link0@yahoo.ca",
        password: "password",
        password_confirmation: "password12spock"
      )
      @user.validate
      expect(@user).to be_invalid
    end
    it "user already in db" do 
      @user = User.new(
        first_name: "bingo",
        last_name: "bongo",
        email: "link0@yahoo.ca",
        password: "password",
        password_confirmation: "password"
      )
      @user.save
      @user_dupe = User.new(
        first_name: "Bichael",
        last_name: "Minnick",
        email: "link0@yahoo.ca",
        password: "eviltwin92",
        password_confirmation: "eviltwin92"
      )
      @user_dupe.validate 
      expect(@user_dupe.errors.full_messages).to include("Email has already been taken")
    end 
    describe "must have valid first_name, last_name, email, password and password_confirmation fields" do
      it "should be invalid when first_name is blank" do
        @user = User.new(
          first_name: nil,
          last_name: "bongo",
          email: "bongo@gg.com",
          password: "password",
          password_confirmation: "password"
        )
        @user.validate
        expect(@user).to be_invalid
      end
    
      it "should be invalid when last_name is blank" do
        @user = User.new(
          first_name: "bingo",
          last_name: nil,
          email: "link0@yahoo.ca",
          password: "password",
          password_confirmation: "password"
        )
        @user.validate
        expect(@user).to be_invalid
      end
    
      it "invalid when email is blank" do
        @user = User.new(
          first_name: "bingo",
          last_name: "bongo",
          password: "password",
          password_confirmation: "password"
        )
        @user.validate
        expect(@user).to be_invalid
      end
    
      it "invalid when password is blank" do
        @user = User.new(
          first_name: "bingo",
          last_name: "bongo",
          email: "link0@yahoo.ca",
          password: nil,
          password_confirmation: "password"
        )
        @user.validate
        expect(@user).to be_invalid
      end
    
      it "invalid when password_confirmation is blank" do
        @user = User.new(
          first_name: "bingo",
          last_name: "bongo",
          email: "link0@yahoo.ca",
          password: "password",
          password_confirmation: nil
        )
        @user.validate
        expect(@user).to be_invalid
      end
    
    end
    it "fails to validate if password is under min length(8)" do
      @user = User.new(
        first_name: "bingo",
        last_name: "bongo",
        email: "link0@yahoo.ca",
        password: "pass",
        password_confirmation: "pass"
      )
      @user.validate
      expect(@user).to be_invalid
    end
  end

  describe ".authenticate_with_credentials" do

    it "authenticates with correct password" do
      @user = User.new(
        first_name: 'bingo',
        last_name: 'bongo',
        email: 'link0@yahoo.ca',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      user = User.authenticate_with_credentials("link0@yahoo.ca", "password")
      expect(user).to_not be_nil
    end

    it "doesnt authenticate with incorrect password" do
      @user = User.new(
        first_name: 'bingo',
        last_name: 'bongo',
        email: 'link0@yahoo.ca',
        password: 'passwsord',
        password_confirmation: 'password'
      )
      @user.save
      user = User.authenticate_with_credentials("link0@yahoo.ca", "password12woops")
      expect(user).to be_nil
    end

    it "doesnt authorize nonexisting email" do
      user = User.authenticate_with_credentials("martianman@earth.com", "eepeepzorp")
      expect(user).to be_nil
    end

    it "should authenticate if email uppercase" do
      @user = User.new(
        first_name: 'bingo',
        last_name: 'bongo',
        email: 'lInk0@yahoo.ca',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      user = User.authenticate_with_credentials("link0@yahoo.ca", "password")
      expect(user).to_not be_nil
    end

    it "should authenticate if email white space is inclueded" do
      @user = User.new(
        first_name: 'bingo',
        last_name: 'bongo',
        email: 'link0@yahoo.ca',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
      user = User.authenticate_with_credentials("link0@yahoo.ca   ", "password")
      expect(user).to_not be_nil
    end

  end

end