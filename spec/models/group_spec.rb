require 'rails_helper'
RSpec.describe Course, type: :model do
  describe 'course associations' do
    it 'belongs to user' do
      expect { should belongs_to(user) }
    end
    it ' belongs to group' do
      expect { should has_many(courses) }
    end
  end
end

feature 'User can create new group' do
  scenario 'user can create group' do
    user = User.create!(name: 'amira', username: 'amira1', password: '123456',
                        email: 'amira@gmail.com')

    visit user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'

    visit groups_path
    click_on 'ADD NEW'
    visit new_group_path
    expect { should have_content('ADD GROUP') }
  end
end

feature 'Validation of group name' do
  scenario 'User gets error message if invalid group name is entered' do
    user = User.create!(name: 'amira', username: 'amira1', password: '123456',
                        email: 'amira@gmail.com')
    group = ['hkjzvnvjdn sgrjdrogbn']

    visit user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'

    visit groups_path
    click_on 'ADD NEW'
    visit new_group_path
    fill_in 'group[name]', with: group[0]
    click_on 'Create Group'
    expect { should have_content('Name is too long (maximum is 20 characters)') }
  end
end

feature 'Validation of group icon' do
  scenario 'User gets error message if invalid/not unique group icon is entered' do
    user = User.create!(name: 'amira', username: 'amira1', password: '123456',
                        email: 'amira@gmail.com')
    group1 = ['chemistry', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.0CHyKOTeLrsf9H1dRavHKwHaK9%26pid%3DApi&f=1']
    group2 = ['arabic', 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.0CHyKOTeLrsf9H1dRavHKwHaK9%26pid%3DApi&f=1']

    visit user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_on 'Log in'

    visit groups_path
    click_on 'ADD NEW'
    visit new_group_path
    fill_in 'group[name]', with: group1[0]
    fill_in 'group[icon]', with: group1[1]
    click_on 'Create Group'
    visit new_group_path
    fill_in 'group[name]', with: group2[0]
    fill_in 'group[icon]', with: group2[1]
    click_on 'Create Group'
    expect { should have_content('Icon has already been taken') }
  end
end
