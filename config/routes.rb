Issues::Engine.routes.draw do
  scope 'projects/:project_id' do
    get 'issues' => 'issues#index', :as => :project_issues
  end
end
