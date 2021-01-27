require 'rails_helper'

RSpec.describe 'ログインとログアウト', type: :system do
  before do
    @user = User.create!(email: 'test@example.com', password: 'password')
  end

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