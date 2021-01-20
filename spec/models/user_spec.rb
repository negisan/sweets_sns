require 'rails_helper'

RSpec.describe User, type: :model do
  it "メール、パスワードがある場合有効" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "メールアドレスがない場合、無効" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end
  it "重複したメールアドレスの場合、無効" do
    user = FactoryBot.create(:user, email: "duple@example.com")
    user2 = FactoryBot.build(:user, email: user.email)
    expect(user2).to_not be_valid
  end

  it "パスワードがない場合、無効" do
    user = FactoryBot.build(:user, password: "")
    expect(user).to_not be_valid
  end
end
