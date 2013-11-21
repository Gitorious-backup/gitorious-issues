module Issues

  class ApplicationController < ActionController::Base

    def pjax_request?
      request.headers["X-PJAX"]
    end

  end

end
