require 'rails_helper'

RSpec.describe 'ログインしていないユーザー', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user_id: user.id) }




  describe 'テンプレートの表示' do
    describe 'header' do
      it 'サインアップが表示される' do
        visit root_path
        expect(page).to have_selector 'a', text: 'サインアップ'
      end

      it 'ログインが表示される' do
        visit root_path
        expect(page).to have_selector 'a', text: 'ログイン'
      end

      it 'ログアウトが表示されない' do
        visit root_path
        expect(page).to_not have_selector 'a', text: 'ログアウト'
      end

      it 'Homeへのリンクが表示される' do
        visit root_path
        expect(page).to have_selector 'a', text: 'Home'
      end
    end

    describe '投稿詳細ページ' do
      before do
        visit post_path(post)
      end

      it "showページにアクセスできる" do
        expect(page).to have_selector 'img[alt="sample.jpg"]'
      end

      it '編集リンクが表示されない' do
        expect(page).to_not have_selector 'a', text: '編集'
      end

      it '削除リンクが表示されない' do
        expect(page).to_not have_selector 'a', text: '削除'
      end

      it '投稿者のアバターが表示される' do
        expect(page).to have_selector 'img[id="user_avatar"]'
      end
    end

    describe 'Home' do
      before do
        visit root_path
      end

      it '投稿にユーザーアバターが表示されている' do
        expect(page).to have_selector 'img[id="user_avatar"]'
      end

      it '投稿のユーザーアバターをクリックするとユーザー詳細ページにアクセスできる' do
        first("#user_avatar").click
        expect(page).to have_content "#{post.user.name}の投稿"
      end

      it '投稿にひとことが表示されていない' do
        expect(page).to_not have_content post.body
      end

      it '新着投稿一覧ページへのリンクがある' do
        expect(page).to have_selector 'a[href="/posts"]'
      end

      it '週間いいねランキング一覧ページへのリンクがある' do
        expect(page).to have_selector 'a[href="/weekly_ranking"]'
      end

      it '総合いいねランキング一覧ページへのリンクがある' do
        expect(page).to have_selector 'a[href="/all_time_ranking"]'
      end
    end

    describe '投稿一覧ページ' do
      shared_examples_for '各一覧ページのリンクバーが表示されている' do
        it {
          expect(page).to have_css '#ranking_link_bar'
          expect(page).to have_selector 'a[href="/posts"]'
          expect(page).to have_selector 'a[href="/weekly_ranking"]'
          expect(page).to have_selector 'a[href="/all_time_ranking"]'
        }
      end

      describe '新着投稿一覧ページ' do
        before do
          visit posts_path
        end

        it 'アクセスできる' do
          expect(page).to have_content '新着投稿一覧'
        end

        it_behaves_like '各一覧ページのリンクバーが表示されている'
      end

      describe '週間いいねランキングページ' do
        before do
          visit weekly_ranking_path
        end

        it "アクセスできる" do
          expect(page).to have_content '週間いいねランキング'
        end

        it_behaves_like '各一覧ページのリンクバーが表示されている'
      end

      describe '総合いいねランキングページ' do
        before do
          visit all_time_ranking_path
        end

        it 'アクセスできる' do
          expect(page).to have_content '総合いいねランキング'
        end

        it_behaves_like '各一覧ページのリンクバーが表示されている'
      end
    end
  end




  describe '投稿機能' do
    it "newページへアクセスできない" do
      visit post_path(post)
      expect(page).to_not have_content '投稿の新規作成'
    end

    it "editページへアクセスできない" do
      visit edit_post_path(post)
      expect(page).to_not have_content '投稿の編集'
    end
  end




  describe 'Like機能' do
    describe 'Home' do
      it "Likeボタンが表示される" do
        visit root_path
        expect(page).to have_selector 'a', id: 'like_btn'
      end

      it "Likeボタンを押すとログインページへ遷移する" do
        visit root_path
        find('#like_btn').click
        expect(page).to have_content 'ログイン'
      end
    end

    describe '投稿詳細' do
      it "Likeボタンが表示される" do
        visit post_path(post)
        expect(page).to have_selector 'a', id: 'like_btn'
      end

      it "Likeボタンを押すとログインページへ遷移する" do
        visit post_path(post)
        find('#like_btn').click
        expect(page).to have_content 'ログイン'
      end
    end
  end



  describe 'コメント機能' do
    let!(:comment) { FactoryBot.create(:comment, user_id: user.id, post_id: post.id) }

    before do
      visit post_path(post)
    end

    it 'コメントが表示されている' do
      expect(page).to have_css '#comment-item'
    end

    it 'コメントを投稿したユーザーが表示されている' do
      expect(page).to have_css '#comment-user'
    end

    it 'コメント入力欄が表示されていない' do
      expect(page).to_not have_selector 'div[id="comment-input-area"]'
    end
  end
end





RSpec.describe 'ログインしているユーザー', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user_id: user.id) }


  before do
    sign_in user
  end



  describe 'テンプレートの表示' do
    describe "投稿の新規作成ページ" do
      it "アクセスできる" do
        visit new_post_path
        expect(page).to have_content '投稿の新規作成'
      end
    end

    describe "投稿詳細ページ" do
      before do
        visit post_path(post)
      end

      it "画像が表示される" do
        expect(page).to have_selector 'img[alt="sample.jpg"]'
      end

      it '投稿者のアバターが表示される' do
        expect(page).to have_selector 'img[id="user_avatar"]'
      end

      context '投稿を作成したユーザーとログインしているユーザーが一致' do
        it '編集リンクが表示される' do
          expect(page).to have_selector 'a', text: '編集'
        end

        it '削除リンクが表示される' do
          expect(page).to have_selector 'a', text: '削除'
        end
      end

      context '投稿を作成したユーザーとログインしているユーザーが違う' do
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

    describe 'Home' do
      before do
        sign_in user
        visit root_path
      end

      it '投稿にユーザーアバターが表示されている' do
        expect(page).to have_selector 'img[id="user_avatar"]'
      end

      it '投稿のユーザーアバターをクリックするとユーザー詳細ページにアクセスできる' do
        first("#user_avatar").click
        expect(page).to have_content "#{post.user.name}の投稿"
      end

      it '投稿にひとことが表示されていない' do
        expect(page).to_not have_content post.body
      end
    end
  end




  describe '投稿機能' do
    describe 'posts/new' do
      before do
        visit new_post_path
      end

      it '有効な入力で投稿できる' do
        page.attach_file('spec/fixtures/sample.jpg') do
          page.find('.custom-file').click
        end
        fill_in 'ひとこと', with: 'test'
        click_button '送信'
        expect(page).to have_content '投稿しました'
      end

      it 'ひとことが空で投稿できない' do
        page.attach_file('spec/fixtures/sample.jpg') do
          page.find('.custom-file').click
        end
        click_button '送信'
        expect(page).to_not have_content '投稿しました'
      end

      it '画像が空だと投稿できない' do
        fill_in 'ひとこと', with: 'test'
        click_button '送信'
        expect(page).to_not have_content '投稿しました'
      end
    end

    describe '投稿編集ページ' do
      before do
        visit edit_post_path(post)
      end

      it 'ページを開いたときに編集対象の画像が表示される' do
        expect(page).to have_selector 'img[title="image"]'
      end

      it '有効な入力で更新できる' do
        page.attach_file('spec/fixtures/sample.jpg') do
          page.find('.custom-file').click
        end
        fill_in 'ひとこと', with: 'test2'
        click_button '送信'
        expect(page).to have_content '投稿を更新しました'
      end

      it 'ひとことが空で更新できる' do
        page.attach_file('spec/fixtures/sample.jpg') do
          page.find('.custom-file').click
        end
        click_button '送信'
        expect(page).to have_content '投稿を更新しました'
      end

      it '取消ボタンで画像を除去できる' do
        click_button '取消'
        expect(page).to_not have_selector 'image[title="image"]'
      end
    end

    describe '投稿詳細ページ' do
      before do
        visit post_path(post)
      end

      it '投稿が削除できる' do
        page.accept_confirm do
          click_on '削除'
        end
        expect(page).to have_content '投稿を削除しました'
      end
    end

    describe '投稿制限がかかっている' do
      let(:user) { FactoryBot.create(:user, prohibition: true) }

      it '新規投稿ページへアクセスできない' do
        visit new_post_path
        expect(page).to have_content '機能が制限されています'
      end

      it '投稿の編集ができない' do
        visit post_path(post)
        click_on '編集'
        expect(page).to have_content '機能が制限されています'
      end

      it '投稿の削除ができない' do
        visit post_path(post)
        expect{
          page.accept_confirm do
            click_on '削除'
          end
        }.to_not change{Post.count}
      end

      it 'コメントができない' do
        visit post_path(post)
        fill_in 'comment-input-form', with: 'コメントのテスト'
        click_on 'comment-submit-btn'
        expect(page).to have_content '機能が制限されています'
      end
    end
  end




  describe 'Like機能' do
    describe '投稿詳細ページ' do
      it "Likeボタンが表示される" do
        visit post_path(post)
        expect(page).to have_selector 'a', id: 'like_btn'
      end

      it "Likeボタンを押すとLike済になる" do
        visit post_path(post)
        find('#like_btn').click
        expect(find('#like_btn')).to have_css '.fas'
      end

      it "Like済のボタンを押すとLikeが解除される" do
        visit post_path(post)
        find('#like_btn').click
        expect(find('#like_btn')).to have_css '.fas'
        sleep 1
        find('#like_btn').click
        expect(find('#like_btn')).to have_css '.far'
      end
    end

    describe 'home' do
      it "Likeボタンが表示される" do
        visit root_path
        expect(page).to have_selector 'a', id: 'like_btn'
      end

      it "Likeボタンを押すとLike済になる" do
        visit root_path
        find('#like_btn').click
        expect(find('#like_btn')).to have_css '.fas'
      end

      it "Like済のボタンを押すとLikeが解除される" do
        visit root_path
        find('#like_btn').click
        expect(find('#like_btn')).to have_css '.fas'
        sleep 1
        find('#like_btn').click
        expect(find('#like_btn')).to have_css '.far'
      end
    end
  end




  describe 'コメント機能' do
    let!(:comment) { FactoryBot.create(:comment, user_id: user.id, post_id: post.id) }

    before do
      visit post_path(post)
    end

    it 'コメントが表示されている' do
      expect(page).to have_css '#comment-item'
    end

    it 'コメントを投稿したユーザーが表示されている' do
      expect(page).to have_css '#comment-user'
    end

    it 'コメント入力欄が表示されている' do
      expect(page).to have_selector 'div[id="comment-input-area"]'
    end

    it 'コメントを投稿できる' do
      fill_in 'comment-input-form', with: 'コメントのテスト投稿'
      click_button 'comment-submit-btn'
      expect(page).to have_content 'コメントのテスト投稿'
    end
  end
end


