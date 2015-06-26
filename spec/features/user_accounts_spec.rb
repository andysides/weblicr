require 'feature_helper'

RSpec.feature 'User Accounts' do
  let(:other_user) { create(:user) }

  context 'When I am a guest' do
    scenario 'I do not see an edit profile link' do
      visit user_path(other_user)
      expect(page).to_not have_link I18n.t('user.edit.link')
      visit edit_user_path(other_user)
      expect(page).to have_content I18n.t('user.edit.access_denied')
    end
  end

  context 'When I am logged in' do
    let(:user) { create(:user) }
    let(:new_email) { "new-email@weblinc.com" }

    scenario 'I cannot edit other user profiles' do
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button I18n.t('user.fields.login')
      visit user_path(other_user)
      expect(page).to_not have_link I18n.t('user.edit.link')
      visit edit_user_path(other_user)
      expect(page).to have_content I18n.t('user.edit.access_denied')
    end

    scenario 'I can edit my own profile' do
      visit login_path
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button I18n.t('user.fields.login')
      visit edit_user_path(user)
      fill_in 'user_email', with: new_email
      click_button I18n.t('user.fields.edit')
      expect(page).to have_content I18n.t('user.edit.success_message')
    end
  end
end
