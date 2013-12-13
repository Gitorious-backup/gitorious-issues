module Issues
  module Presenters
    class IssuePresenter
      include Charlatan.new(:issue)

      def to_s
        title
      end

      def user_name
        user.fullname || user.login
      end

      def renderer(view)
        Renderers::IssueRenderer.new(view, self)
      end
    end
  end
end
