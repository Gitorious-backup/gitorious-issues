require 'authenticated_system'

module Issues

  class ApplicationController < ActionController::Base
    include AuthenticatedSystem

    def pjax_request?
      request.headers["X-PJAX"]
    end

  end

end
