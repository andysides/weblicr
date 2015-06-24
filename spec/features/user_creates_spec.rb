require 'feature_helper'

RSpec.feature 'VisitStaticHomePage' do
  let(:email) {'test@test.com'}
  let(:password) {'testing123'}
  let(:password_confirmation) {'testing123'}

  context 'As an unregistered user' do
    context 'with acceptable user info' do
      scenario 'I can register new account' do
        visit root_url
        click_link I18n.t('user.sign_up.link')
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password_confirmation
        click_button I18n.t('user.fields.submit')
        expect(page).to have_content I18n.t('user.sign_up.success')
      end
    end

    context 'with unacceptable user info' do
      let(:password_confirmation) {''}

      scenario 'I cannot register new account' do
        visit root_url
        click_link I18n.t('user.sign_up.link')
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password_confirmation
        click_button I18n.t('user.fields.submit')
        expect(page).to have_content I18n.t('user.errors.message')
      end
    end
  end
end
