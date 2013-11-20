module Gitorious
  module Issues
    class Engine < ::Rails::Engine
      isolate_namespace Gitorious::Issues
    end
  end
end
