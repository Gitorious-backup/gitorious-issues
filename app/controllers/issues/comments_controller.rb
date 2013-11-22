module Issues

  class CommentsController < ::ApplicationController
    include ProjectFilters

    before_filter :login_required, :except => [:index, :show]
    before_filter :find_project
    before_filter :find_issue
    before_filter :find_comments, :only => [:index]

    helper 'issues/application'
    layout 'issues'

    attr_reader :comments, :project, :issue

    def index
      render_index
    end

    def new
      render_form(issues.comments.build(:user => current_user))
    end

    def create
      comment = issue.comments.build(params[:comment])
      comment.user = current_user

      if comment.save
        flash[:notice] = 'Comment added successfuly'
        redirect_to [project, issue]
      else
        render_form(comment)
      end
    end

    private

    def find_comments
      @comments = issue.comments
    end

    def find_issue
      @issue = Issue.find_by_project_id_and_issue_id!(project.id, params[:issue_id])
    end

    def render_index
      render(
        :template => 'issues/comments/index',
        :locals => { :comments => comments, :active => :issues },
        :layout => pjax_request? ? false : true
      )
    end

    def render_form(comment)
      render(
        :partial => 'issues/comments/form',
        :locals => { :comment => comment, :active => :issues },
        :layout => pjax_request? ? false : true
      )
    end

  end

end
