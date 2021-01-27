require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    user = FactoryBot.build(:user)
    post = FactoryBot.build(:post)
  end

  it 'bodyが200文字以下の場合、有効' do
  end
end
