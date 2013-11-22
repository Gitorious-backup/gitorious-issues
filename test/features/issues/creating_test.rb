require "test_helper"

feature 'Create an issue' do
  include CapybaraTestCase

  fixtures :users, :projects

  let(:user)    { Features::User.new(users(:johan), self) }
  let(:project) { projects(:johans) }
  let(:routes)  { Issues::Engine.routes.url_helpers }

  background do
    user.sign_in
  end

  scenario 'visting project issues page' do
    visit routes.new_project_issue_path(project)

    user.create_issue

    page.must_have_content('issue #1')

    click_on 'issue #1'

    page.must_have_content('issue #1')
    page.must_have_content('test issue')

    click_on 'Edit'

    find('#issue_title').set('issue number one')
    click_on 'Save'

    page.must_have_content('Issue updated successfuly')
    page.must_have_content('issue number one')
  end
end
