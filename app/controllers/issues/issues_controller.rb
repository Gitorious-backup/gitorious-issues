module Issues

  class IssuesController < ApplicationController
    before_filter :load_project
    before_filter :load_issues, :only => [:index]

    attr_reader :project, :issues

    def index
      render :template => 'issues/issues/index', :locals => {
        :project => project, :issues => issues
      }
    end

    private

    def load_issues
      @issues = Issue.where(:project_id => project.id)
    end

    def load_project
      @project = Project.find_by_slug!(params[:project_id])
    end

  end

end
