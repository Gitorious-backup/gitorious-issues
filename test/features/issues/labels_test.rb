require "test_helper"

feature 'Managing project issue labels' do
  let(:user)    { Features::User.new(users(:johan), self) }
  let(:project) { projects(:johans) }
  let(:routes)  { Issues::Engine.routes.url_helpers }

  background do
    user.sign_in
  end

  scenario 'creating a new label', :js => true do
    user.create_label

    within('.gts-project-issue-labels') do
      assert page.has_content?('feature')
    end
  end

  scenario 'deleting a label', :js => true do
    user.create_label

    visit routes.project_issues_path(project)

    click_on 'Manage labels'

    within('.gts-project-issue-labels') do
      click_on 'Delete'
      sleep 0.5
      refute page.has_content?('feature')
    end
  end
end
