require "test_helper"

feature 'Listing issues' do
  include CapybaraTestCase

  js_test

  let(:user)    { Features::User.new(users(:johan), self) }
  let(:project) { projects(:johans) }
  let(:routes)  { Issues::Engine.routes.url_helpers }

  background do
    user.sign_in

    3.times { |i| user.create_issue(:title => "issue ##{i}") }
  end

  scenario 'visting project issues page' do
    visit routes.project_issues_path(project)

    assert_content page, project.title
    assert_content page, 'issue #1'
    assert_content page, 'issue #2'
    refute_content page, 'issue #3'

    click_on 'issue #1'

    find('#comment_body').set('oh hai')
    click_on('Save')

    page.must_have_content 'Comment added successfuly'
    page.must_have_content 'oh hai'

    within(".gts-comment-list") do
      click_on 'Edit'
    end

    find('#comment_body').set('oh hai again')
    click_on 'Save'
    page.must_have_content 'Your comment was updated'
    page.must_have_content 'oh hai again'
  end
end
