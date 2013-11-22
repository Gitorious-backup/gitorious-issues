require 'test_helper'

describe Issue do
  fixtures :users, :projects

  describe 'validations' do
    it 'has errors when title is blank' do
      issue = Issue.create(:title => '')

      issue.errors[:title].must_include("can't be blank")
      issue.persisted?.must_equal(false)
    end

    it 'has errors when user is blank' do
      issue = Issue.create(:user_id => nil)

      issue.errors[:user].must_include("can't be blank")
      issue.persisted?.must_equal(false)
    end

    it 'has errors when project is blank' do
      issue = Issue.create(:project_id => nil)

      issue.errors[:project].must_include("can't be blank")
      issue.persisted?.must_equal(false)
    end
  end

  describe '#create' do
    let(:user)    { users(:johan) }
    let(:project) { projects(:johans) }

    it 'persists issue when it has valid attributes' do
      issue = Issue.create(
        :title => 'test issue',
        :project => project,
        :user => user
      )

      issue.persisted?.must_equal(true)
      issue.issue_id.must_equal(1)
      issue.state.must_equal('new')
    end
  end
end
