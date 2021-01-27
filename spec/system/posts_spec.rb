require 'rails_helper'

RSpec.describe 'ログインしていないユーザー', type: :system do
  describe 'テンプレートの表示' do
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.create(:post, user_id: user.id) }

    describe 'posts/show' do
      it "showページにアクセスできる" do
        visit post_path(post)
        expect(page).to have_selector 'img[alt="sample.jpg"]'
      end

      it '編集リンクが表示されない' do
        visit post_path(post)
        expect(page).to_not have_selector 'a', text: '編集'
      end

      it '削除リンクが表示されない' do
        visit post_path(post)
        expect(page).to_not have_selector 'a', text: '削除'
      end
    end

    describe 'posts/new' do
      it "newページへアクセスできない" do
        visit post_path(post)
        expect(page).to_not have_content '投稿の新規作成'
      end
    end
  end
end



RSpec.describe 'ログインしているユーザー', type: :system do
  describe 'テンプレートの表示' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }
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

      it "画像が表示される" do
        visit post_path(post)
        expect(page).to have_selector 'img[alt="sample.jpg"]'
      end


      context 'postを作成したユーザーとログインしているユーザーが一致' do
        before do
          visit post_path(post)
        end

        it '編集リンクが表示される' do
          expect(page).to have_selector 'a', text: '編集'
        end

        it '削除リンクが表示される' do
          expect(page).to have_selector 'a', text: '削除'
        end
      end


      context 'postを作成したユーザーとログインしているユーザーが違う' do
        before do
          sign_in user2
          visit post_path(post)
        end

        it '編集リンクが表示されない' do
          expect(page).to_not have_selector 'a', text: '編集'
        end

        it '削除リンクが表示されない' do
          expect(page).to_not have_selector 'a', text: '削除'
        end
      end
    end
  end

  describe '投稿機能' do
    it
  end
end


