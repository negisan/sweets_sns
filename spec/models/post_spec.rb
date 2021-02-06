require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'bodyが300文字以下の場合、有効' do
    post = build(:post, user_id: user.id, body: "a" * 300)
    expect(post).to be_valid
  end

  it 'bodyが300文字以上の場合、無効' do
    post = build(:post, user_id: user.id, body: "a" * 301)
    expect(post).to_not be_valid
  end

  it '画像が添付されていない場合、無効' do
    post = Post.new(user_id: user.id, body: "test")
    expect(post).to_not be_valid
  end
end
