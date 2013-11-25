module Issues
  class Engine < ::Rails::Engine
    isolate_namespace Issues

    config.to_prepare do
      [
        '/ui3/js/lib/jquery-ui/themes/base/minified/jquery-ui.min',
        '/assets/issues/application'
      ].each do |name|
        path = "#{name}.css"
        unless Gitorious::View.stylesheets.include?(path)
          Gitorious::View.stylesheets << path
        end
      end

      [
        '/ui3/js/lib/jquery-ui/ui/jquery.ui.menu',
        '/ui3/js/lib/jquery-ui/ui/jquery.ui.autocomplete',
        '/assets/issues/application'
      ].each do |name|
        path = "#{name}.js"
        unless Gitorious::View.javascripts.include?(path)
          Gitorious::View.javascripts << path
        end
      end
    end
  end
end
