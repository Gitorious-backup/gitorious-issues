Rails.application.routes.draw do
  mount Issues::Engine => "/issues"
end
