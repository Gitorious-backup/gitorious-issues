module Issues
  module UseCases

    class CreateIssue
      attr_reader :user, :project, :params, :issue

      class Params
        include Virtus.model

        attribute :title,        String
        attribute :description,  String
        attribute :state,        String, :default => 'new'
        attribute :milestone_id, Integer
        attribute :assignee_ids, Array[Integer]
        attribute :label_ids,    Array[Integer]
      end

      def self.call(context)
        usecase = new(
          context.fetch(:user),
          context.fetch(:project),
          Issues::Params::IssueParams.new(context.fetch(:params))
        )
        usecase.execute.issue
      end

      def initialize(user, project, params)
        @user, @project, @params = user, project, params
      end

      def execute
        @issue = Issue.new(params.to_hash)

        @issue.user = user
        @issue.project = project

        @issue.save
        self
      rescue ActiveRecord::RecordNotUnique
        @issue.errors.add(:issue_id, 'must be unique')
        @issue.issue_id = nil
        self
      end

    end

  end
end
