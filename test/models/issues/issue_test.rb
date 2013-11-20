require 'test_helper'

describe Issue do
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
end
