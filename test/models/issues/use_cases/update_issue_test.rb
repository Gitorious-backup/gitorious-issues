require 'test_helper'

describe Issues::Issue do
  fixtures 'users', 'projects', 'issues/issues', 'issues/labels'

  let(:issue) { issues_issues('one') }

  describe '.call' do
    it 'update existing issue' do
      Issues::UseCases::UpdateIssue.call(:issue => issue, :params => { :title => 'other' })

      issue.reload

      assert issue.persisted?
      assert_equal 'other', issue.title
    end
  end
end
