require "test_helper"

feature 'Listing issues' do
  fixtures :users, :projects

  include Issues::Engine.routes.url_helpers

  let(:user)    { users(:johan) }
  let(:project) { projects(:johans) }

  background do
    Issue.create!(:title => 'issue #1', :project => project, :user => user)
    Issue.create!(:title => 'issue #2', :project => project, :user => user)
    Issue.create!(:title => 'issue #3', :project => projects(:moes), :user => user)
  end

  scenario 'visting project issues page' do
    visit project_issues_path(project)

    assert_content page, project.title
    assert_content page, 'issue #1'
    assert_content page, 'issue #2'
    refute_content page, 'issue #3'
  end
end
