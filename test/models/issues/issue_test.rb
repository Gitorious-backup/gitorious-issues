require 'test_helper'

describe Issues::Issue do
  fixtures :users, :projects

  describe 'validations' do
    it 'has errors when title is blank' do
      issue = Issues::Issue.create(:title => '')

      issue.errors[:title].must_include("can't be blank")
      issue.persisted?.must_equal(false)
    end

    it 'has errors when user is blank' do
      issue = Issues::Issue.create(:user_id => nil)

      issue.errors[:user].must_include("can't be blank")
      issue.persisted?.must_equal(false)
    end

    it 'has errors when project is blank' do
      issue = Issues::Issue.create(:project_id => nil)

      issue.errors[:project].must_include("can't be blank")
      issue.persisted?.must_equal(false)
    end
  end

  describe 'assignee_candidates' do
    fixtures 'issues/issues', :repositories, :committerships, :groups, :memberships

    it 'returns users from mainlines' do
      issue = issues_issues(:one)
      johan = users(:johan)

      issue.assignee_candidates.must_equal([johan])
    end
  end

  describe '#create' do
    let(:user)    { users(:johan) }
    let(:project) { projects(:johans) }

    it 'persists issue when it has valid attributes' do
      issue = Issues::Issue.create(
        :title => 'test issue',
        :project => project,
        :state => 'new',
        :user => user
      )

      issue.persisted?.must_equal(true)
      issue.state.must_equal('new')
    end
  end
end
