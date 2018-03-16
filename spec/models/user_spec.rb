require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do

    it "姓、名、メール、パスワードがあれば、有効な状態であること" do
      expect(build(:user)).to be_valid
    end

    it "姓がなければ、無効な状態であること" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it "名がなければ、無効な状態であること" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("can't be blank")
    end

    it "メールアドレスがなければ、無効な状態であること" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "重複したメールアドレスなら、無効な状態であること" do
      user = create(:user, email: "test@example.com")
      other_user = build(:user, email: "test@example.com")
      other_user.valid?
      expect(other_user.errors[:email]).to include("has already been taken")
    end

    # nameメソッドのテスト
    it "ユーザーのフルネームを文字列として返すこと" do
      user = build(:user, first_name: "Aaron", last_name: "Sumner")
      expect(user.name).to eq("Aaron Sumner")
    end

  end
end
