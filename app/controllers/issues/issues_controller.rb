module Issues

  class IssuesController < ApplicationController
    before_filter :login_required, :except => [:index]
    before_filter :load_project
    before_filter :load_issues, :only => [:index]
    before_filter :build_issue, :only => [:create]

    helper :application

    attr_reader :project, :issues, :issue

    def index
      render_index
    end

    def new
      render_form(Issue.new(:project_id => project.id))
    end

    def create
      if issue.save
        if pjax_request?
          flash[:notice] = 'Issue created successfuly'
          redirect_to [project, :issues]
        else
          render_index
        end
      else
        render_form(issue)
      end
    end

    private

    def load_issues
      @issues = Issue.where(:project_id => project.id)
    end

    def load_project
      @project = Project.find_by_slug!(params[:project_id])
    end

    def build_issue
      @issue = Issue.new(params[:issue])
      @issue.user = current_user
      @issue.project = project
    end

    def render_index
      render(
        :template => 'issues/issues/index',
        :locals => { :project => project, :issues => issues },
        :layout => pjax_request? ? false : true
      )
    end

    def render_form(issue)
      render(
        :template => 'issues/issues/new',
        :locals => { :project => project, :issue => issue },
        :layout => pjax_request? ? false : true
      )
    end

  end

end
