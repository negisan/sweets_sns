require 'rails_helper'

RSpec.describe 'postsのテンプレートの表示', type: :system do
  describe "posts/new" do
    it "ログイン済みのユーザーがnewページへアクセスできる" do
    end

    it "ログインしていないユーザーはnewページへアクセスできない" do
    end
  end

  describe "posts/show" do
    it "全ユーザーがshowページにアクセスできる" do
    end

    it "画像が表示される" do
    end

    it 'postを作成したユーザーと現在のユーザーが一致したら編集リンクが表示される' do
    end

    it 'postを作成したユーザーと現在のユーザーが一致したら削除リンクが表示される'

  end
end
