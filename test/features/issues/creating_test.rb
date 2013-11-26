require "test_helper"

feature 'Create an issue' do
  let(:user)    { Features::User.new(users(:johan), self) }
  let(:project) { projects(:johans) }
  let(:routes)  { Issues::Engine.routes.url_helpers }

  scenario 'visting project issues page', :js => true do
    user.sign_in

    visit routes.new_project_issue_path(project)

    user.create_issue

    page.must_have_content('issue #1')

    click_on 'issue #1'

    page.must_have_content('issue #1')
    page.must_have_content('test issue')

    click_on 'Edit'

    find('#issue_title').set('issue number one')
    find('#issue_assignee_candidate').set('johan')

    click_on 'Assign'
    click_on 'Save'

    page.must_have_content('Issue updated successfuly')
    page.must_have_content('issue number one')

    click_on 'issue number one'

    within('.issue-assignees') do
      page.must_have_content 'johan'
    end
  end
end
