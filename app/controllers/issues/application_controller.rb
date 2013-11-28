module Issues

  module IssueAuthorization
    def self.included(controller)
      controller.send(:helper_method, :can_edit?)
      controller.send(:helper_method, :can_manage?)
    end

    def authorize
      unless can_edit?
        flash[:warning] = 'You are not authorized to access this page'
        redirect_to(main_app.root_path) and return
      end
    end

    def can_edit?(issue = issue)
      admin?(current_user, project) || issue.creator?(current_user)
    end

    def can_manage?(issue = issue)
      admin?(current_user, project)
    end
  end

  class ApplicationController < ::ApplicationController
    include ProjectFilters
  end

end
