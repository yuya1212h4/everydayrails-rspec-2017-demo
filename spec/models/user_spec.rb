require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do

    it "姓、名、メール、パスワードがあれば、有効な状態であること" do
      user = User.new(
        first_name: "Aaron",
        last_name: "Sumner",
        email: "test@example.com",
        password: "password"
      )
      expect(user).to be_valid
    end

    it "姓がなければ、無効な状態であること" do
      user = User.new(last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "名がなければ、無効な状態であること" do
      user = User.new(first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "メールアドレスがなければ、無効な状態であること" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "重複したメールアドレスなら、無効な状態であること" do
      user = User.create(
        first_name: "Aaron",
        last_name: "Sumner",
        email: "test@example.com",
        password: "password"
      )
      user = User.new(
        first_name: "Aaron",
        last_name: "Sumner",
        email: "test@example.com",
        password: "password"
      )
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "ユーザーのフルネームを文字列として返すこと" do
      user = User.create(
        first_name: "Aaron",
        last_name: "Sumner",
        email: "test@example.com",
        password: "password"
      )
      expect(user.name).to eq("Aaron Sumner")
    end

  end
end
