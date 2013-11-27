require "test_helper"

feature 'Create an issue' do
  let(:user)    { Features::User.new(users(:johan), self) }
  let(:project) { projects(:johans) }
  let(:routes)  { Issues::Engine.routes.url_helpers }

  background do
    Issues::Label.create!(:color => 'red', :name => 'bug', :project => project)
  end

  scenario 'visting project issues page', :js => true do
    user.sign_in

    visit routes.new_project_issue_path(project)

    user.create_issue(:title => 'issue #1')
    user.create_issue(:title => 'issue #2')
    user.create_issue(:title => 'issue #3')

    assert page.has_content?('issue #1')
    assert page.has_content?('issue #2')
    assert page.has_content?('issue #3')

    click_on 'issue #1'

    page.must_have_content('issue #1')
    page.must_have_content('test issue')

    click_on 'Edit'

    find('#issue_title').set('issue number one')

    within('.issue-assignee-widget') do
      find('#issue_assignee_candidate').set('johan')
      click_on 'Assign'
    end

    within('.issue-label-widget') do
      find('#issue_label').set('bug')
      click_on 'Add'
    end

    click_on 'Save'

    page.must_have_content('Issue updated successfuly')
    page.must_have_content('issue number one')

    click_on 'issue number one'

    within('.issue-assignees') do
      page.must_have_content 'johan'
    end

    within('.issue-labels') do
      page.must_have_content 'bug'
    end

    visit routes.project_issues_path(project)

    find('label', :text => 'bug').click
    click_on 'Filter'

    sleep 0.5

    assert page.has_content?('issue number one')
    refute page.has_content?('issue #2')
    refute page.has_content?('issue #3')
  end
end
