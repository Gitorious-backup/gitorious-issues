module Gitorious::Issues
  class ApplicationController < ActionController::Base

    def index
      render :text => "hello world"
    end

  end
end
