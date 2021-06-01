require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'amira', username: 'amira1', email: 'amira@gmail.com', password: '123456')
  describe 'User functions' do
    it "returns user's name" do
      expect(user.name).to eq('amira')
    end
    it 'returns usersname' do
      expect(user.username).to eq('amira1')
    end
    it 'returns correct password' do
      expect(user.password).to eq('123456')
    end
    it 'returns correct email' do
      expect(user.email).to eq('amira@gmail.com')
    end

    it 'returns correct courses' do
      expect(user.courses).to eq([])
    end

    it 'returns correct groups' do
      expect(user.groups).to eq([])
    end
  end
  describe 'User Associations' do
    it 'has many courses' do
      expect { should has_many(courses) }
    end
    it 'has many groups' do
      expect { should has_many(groups) }
    end
  end
end
feature 'User can sign in' do
  scenario 'user can sign in' do
    user1 = User.create!(name: 'amira', username: 'amira1', password: '123456', email: 'amira@gmail.com')
    visit user_session_path
    fill_in 'user[name]', with: user1.name
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_on 'Log in'
    expect { should have_content('Signed in successfully.') }
  end
end
feature 'User can sign up' do
  scenario 'user can sign up' do
    visit new_user_registration_path
    user1 = ['amira', 'amira1', '123456', 'amira@gmail.com']

    fill_in 'user[name]', with: user1[0]
    fill_in 'user[username]', with: user1[1]
    fill_in 'user[email]', with: user1[3]
    fill_in 'user[password]', with: user1[2]
    fill_in 'user[password_confirmation]', with: user1[2]
    click_on 'Sign up'

    expect { should have_content('Welcome! You have signed up successfully.') }
  end
end
