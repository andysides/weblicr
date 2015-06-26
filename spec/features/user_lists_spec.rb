require 'feature_helper'

RSpec.feature 'User Accounts' do
  context 'When I am a guest' do
    describe 'I can see a list of users' do
      before(:all) do
        @users = []
        6.times do |i|
          @users[i] = create(:user)
        end
      end

      scenario 'and the list is paginated' do
        visit users_path
        expect(page).to have_content @users[0].email
        expect(page).to_not have_content @users[5].email
        click_link 'Next'
        expect(page).to_not have_content @users[0].email
        expect(page).to have_content @users[5].email
      end

      scenario 'and I can view the profile of users' do
        visit users_path
        click_link @users[0].email
        expect(page).to have_content @users[0].email
      end
    end
  end
end
