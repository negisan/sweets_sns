require 'rails_helper'

RSpec.describe 'ログインとログアウト', type: :system do

  let!(:user) { User.create(
    email: 'test@example.com',
    password: 'password'
  )}


  it '有効な入力でログインできる' do
    visit new_user_session_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました'
  end

  it 'ログアウトできる'  do
    visit new_user_session_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_link 'ログアウト'
    click_link 'ログアウト'
    expect(page).to have_link 'ログイン'
  end

  it '無効なメールアドレスでログインできない' do
    visit new_user_session_path
    fill_in 'Eメール', with: ''
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    expect(page).to have_content 'Eメールまたはパスワードが違います'
  end

  it '無効なパスワードでログインできない' do
    visit new_user_session_path
    fill_in 'Eメール', with: 'test@example.com'
    fill_in 'パスワード', with: ''
    click_button 'ログイン'
    expect(page).to have_content 'Eメールまたはパスワードが違います'
  end
end

RSpec.describe 'サインアップ', type: :system do
  before do
    User.create!(email: 'test@example.com', password: 'password')
  end

  it '有効な入力でサインアップに成功する' do
    visit new_user_registration_path
    expect {
      fill_in 'Eメール', with: 'success@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button 'サインアップ'
  }.to change(User, :count).by(1)
  end

  it '重複したメールアドレスでサインアップに失敗する' do
    visit new_user_registration_path
    expect {
      fill_in 'Eメール', with: 'test@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button 'サインアップ'
  }.to_not change{User.count}
  end
end

RSpec.describe 'ログインしていないユーザー', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) {FactoryBot.create(:post, user_id: user.id)}

  describe 'users/show' do
    before do
      visit user_path(user)
    end

    it 'ユーザー詳細ページへアクセスできる' do
      expect(page).to have_content user.name
    end

    it '他のユーザーページでそのユーザーの投稿一覧を見ることができる' do
      expect(page).to have_selector 'div', id: user.name + 'の投稿'
    end

    it 'ユーザーのアバターが表示される' do
      expect(page).to have_selector '#user_avatar'
    end

    it 'ユーザー編集ページへのリンクが表示されない' do
      expect(page).to_not have_selector 'a', text: 'ユーザー情報の編集'
    end
  end
end

RSpec.describe 'ログインしているユーザー', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user_id: user.id) }

  before do
    sign_in user
  end

  describe 'users/show' do
    before do
      visit user_path(user)
    end

    it '自身の投稿一覧が表示される' do
      expect(page).to have_selector 'div', id: user.name + 'の投稿'
    end

    it 'ユーザーのアバターが表示される' do
      expect(page).to have_selector '#user_avatar'
    end

    it 'ユーザー編集ページへのリンクが表示される' do
      expect(page).to have_selector 'a', text: 'ユーザー情報の編集'
    end
  end
end

