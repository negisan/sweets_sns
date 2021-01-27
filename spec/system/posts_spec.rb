require 'rails_helper'

RSpec.describe 'postsのテンプレートの表示', type: :system do
  describe 'ログインしていないユーザー' do
    describe 'posts/show' do
      it "showページにアクセスできる"
    end

    describe 'posts/new' do
      it "ログインしていないユーザーはnewページへアクセスできない"
    end
  end


  describe 'ログインしているユーザー' do
    describe "posts/new" do
      it "newページへアクセスできる"

    end

    describe "posts/show" do

      it 'showページにアクセスできる'

      it "画像が表示される"

      it 'postを作成したユーザーと現在のユーザーが一致したら、編集リンクが表示される'

      it 'postを作成したユーザーと現在のユーザーが一致したら、削除リンクが表示される'

      it 'postを作成したユーザーと現在のユーザーが一致しない場合、編集リンクが表示されない'

      it 'postを作成したユーザーと現在のユーザーが一致しない場合、削除リンクが表示されない'

    end
  end


end
