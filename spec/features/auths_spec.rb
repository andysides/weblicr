require 'feature_helper'

RSpec.feature 'Authentication' do
  let(:password) {'testing123'}
  let(:user) do
    create(:user, password: password, password_confirmation: password)
  end

  context 'Since I exist' do
    let(:email) {user.email}

    context 'when I login with valid credentials' do
      scenario 'I am authenticated' do
        visit root_url
        click_link I18n.t('user.login.link')
        fill_in 'email', with: email
        fill_in 'password', with: password
        click_button I18n.t('user.fields.login')
        expect(page).to have_content I18n.t('user.login.success')
        expect(page).to have_link I18n.t('user.logout.link')
        expect(page).to_not have_link I18n.t('user.sign_up.link')
        expect(page).to_not have_link I18n.t('user.login.link')
      end
    end

    context 'when I login with invalid credentials' do
      scenario 'I am not authenticated' do
        visit root_url
        click_link I18n.t('user.login.link')
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        click_button I18n.t('user.fields.login')
        expect(page).to have_content I18n.t('user.login.failure')
        expect(page).to have_link I18n.t('user.sign_up.link')
        expect(page).to have_link I18n.t('user.login.link')
        expect(page).to_not have_link I18n.t('user.logout.link')
      end
    end
  end
end
