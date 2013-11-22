Issues::Engine.routes.draw do
  scope 'projects/:project_id' do
    get 'issues' => 'issues#index', :as => :project_issues
    get 'issues/new' => 'issues#new', :as => :new_project_issue
    get 'issues/:issue_id' => 'issues#show', :as => :project_issue
    post 'issues' => 'issues#create'
  end
end
