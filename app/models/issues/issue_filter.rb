module Issues

  class IssueFilter
    attr_reader :issues, :query

    def self.call(query)
      new(Issue.sorted, query).issues
    end

    def initialize(issues, query)
      @issues = issues
      @query  = query
      filter!
    end

    private

    def filter!
      @issues = issues.where(:project_id => query.project.id)

      if query.milestone_id.present?
        @issues = issues.where(:milestone_id => query.milestone_id)
      end

      if query.label_ids.any?
        @issues = issues.joins(:labels).where(:issues_labels => { :id => query.label_ids })
      end

      @issues = @issues.group(:id)
    end
  end

end
