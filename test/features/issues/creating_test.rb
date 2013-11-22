require "test_helper"

feature 'Create an issue' do
  include CapybaraTestCase

  fixtures :users, :projects

  let(:user)    { users(:johan) }
  let(:project) { projects(:johans) }
  let(:routes)  { Issues::Engine.routes.url_helpers }

  background do
    visit new_sessions_path
    find('#email').set(user.email)
    find('#password').set('test')
    click_on 'Log in'
  end

  scenario 'visting project issues page' do
    visit routes.new_project_issue_path(project)

    find('#issue_title').set('issue #1')
    find('#issue_description').set('this should be easy to fix luls')

    click_on 'Save'

    page.must_have_content('issue #1')

    click_on 'issue #1'

    page.must_have_content('issue #1')
    page.must_have_content('this should be easy to fix luls')
  end
end
