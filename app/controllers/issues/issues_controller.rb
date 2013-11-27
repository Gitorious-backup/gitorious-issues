module Issues

  class IssuesController < ::ApplicationController
    include ProjectFilters

    before_filter :login_required, :except => [:index, :show]
    before_filter :find_project
    before_filter :find_issues, :only => [:index]
    before_filter :find_issue,  :only => [:show, :edit, :update]
    before_filter :build_issue, :only => [:create]

    helper 'issues/application'
    layout 'issues'

    attr_reader :project, :issues, :issue, :query

    def index
      render_index
    end

    def new
      render_form(Issue.new(:project_id => project.id))
    end

    def create
      assignee_ids = params.fetch(:assignee_ids, [])
      label_ids    = params.fetch(:label_ids, [])

      if issue.save
        issue.update_assignees(assignee_ids)
        issue.update_labels(label_ids)

        if pjax_request?
          render_index
        else
          flash[:notice] = 'Issue created successfuly'
          redirect_to [project, :issues]
        end
      else
        render_form(issue)
      end
    end

    def show
      render(
        :template => 'issues/issues/show',
        :locals => { :project => ProjectPresenter.new(project), :issue => issue, :active => :issues },
        :layout => pjax_request? ? false : true
      )
    end

    def edit
      render(
        :template => 'issues/issues/edit',
        :locals => { :project => ProjectPresenter.new(project), :issue => issue, :active => :issues },
        :layout => pjax_request? ? false : true
      )
    end

    def update
      assignee_ids = params.fetch(:assignee_ids, [])
      label_ids    = params.fetch(:label_ids, [])

      if issue.update_attributes(params[:issue])
        issue.update_assignees(assignee_ids)
        issue.update_labels(label_ids)

        if pjax_request?
          render_index
        else
          flash[:notice] = 'Issue updated successfuly'
          redirect_to [project, :issues]
        end
      else
        render_form(issue)
      end
    end

    private

    def find_issues
      build_query
      @issues = IssueFilter.call(query)
    end

    def find_issue
      @issue = Issue.find_by_project_id_and_issue_id!(project.id, params[:issue_id])
    end

    def build_issue
      @issue = Issue.new(params[:issue])
      @issue.user = current_user
      @issue.project = project
    end

    def build_query
      @query = IssueQuery.new(params, project)
    end

    def render_index
      render(
        :template => 'issues/issues/index',
        :locals => { :project => ProjectPresenter.new(project), :issues => issues, :query => query, :active => :issues },
        :layout => pjax_request? ? false : true
      )
    end

    def render_form(issue)
      render(
        :template => 'issues/issues/new',
        :locals => { :project => ProjectPresenter.new(project), :issue => issue, :active => :issues },
        :layout => pjax_request? ? false : true
      )
    end

  end

end
