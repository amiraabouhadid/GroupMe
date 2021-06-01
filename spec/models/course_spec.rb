require 'rails_helper'
RSpec.describe Course, type: :model do
  describe 'course associations' do
    it 'belongs to user' do
      expect { should belongs_to(user) }
    end
    it ' belongs to group' do
      expect { should belongs_to(group) }
    end
  end
end
feature 'User can create new course' do
  scenario 'user can add new course' do
    user = User.create!(name: 'amira', username: 'amira1', password: '123456',
                        email: 'amira@gmail.com')

    visit user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'

    visit courses_path
    click_on 'ADD NEW'
    visit new_course_path
    expect { should have_content('ADD COURSE') }
  end
end
