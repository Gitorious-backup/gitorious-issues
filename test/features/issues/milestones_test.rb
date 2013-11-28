require "test_helper"

feature 'Managing project milestones' do
  let(:user)    { Features::User.new(users(:johan), self) }
  let(:project) { projects(:johans) }
  let(:routes)  { Issues::Engine.routes.url_helpers }

  background do
    user.sign_in
  end

  scenario 'creating a new milestone', :js => true do
    user.create_milestone(:name => 'v1.0')

    page.must_have_content 'Milestone added successfuly'
    page.must_have_content 'v1.0'
  end

  scenario 'deleting a milestone', :js => true do
    user.create_milestone(:name => 'v1.0')

    within('.gts-project-issue-milestones') do
      click_on 'Delete'
      sleep 0.5
      refute page.has_content?('v1.0')
    end
  end
end
