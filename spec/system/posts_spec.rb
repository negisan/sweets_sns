require 'rails_helper'

RSpec.describe 'ログインしていないユーザー', type: :system do
  describe 'テンプレートの表示' do
    describe 'posts/show' do
      it "showページにアクセスできる"

      it '編集リンクが表示されない'

      it '削除リンクが表示されない'
    end

    describe 'posts/new' do
      it "newページへアクセスできない"
    end
  end
end


RSpec.describe 'ログインしているユーザー', type: :system do
  describe 'テンプレートの表示' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.create(:post, user_id: user.id) }

    before do
      sign_in user
    end

    describe "posts/new" do
      it "newページへアクセスできる" do
        visit new_post_path
        expect(page).to have_content '投稿の新規作成'
      end
    end

    describe "posts/show" do
      it 'showページにアクセスできる' do
        visit post_path(post)
        expect(page).to have_content '投稿詳細'
      end

      it "画像が表示される"

      it 'postを作成したユーザーと現在のユーザーが一致したら、編集リンクが表示される'

      it 'postを作成したユーザーと現在のユーザーが一致したら、削除リンクが表示される'

      it 'postを作成したユーザーと現在のユーザーが一致しない場合、編集リンクが表示されない'

      it 'postを作成したユーザーと現在のユーザーが一致しない場合、削除リンクが表示されない'
    end
  end

  describe '投稿機能' do
    it
  end
end


