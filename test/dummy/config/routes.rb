Rails.application.routes.draw do
  mount Gitorious::Issues::Engine => "/issues"
end
