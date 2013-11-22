Issues::Engine.routes.draw do
  scope 'projects/:project_id' do
    get 'issues' => 'issues#index', :as => :project_issues
    get 'issues/new' => 'issues#new', :as => :new_project_issue
    get 'issues/:issue_id' => 'issues#show', :as => :project_issue
    get 'issues/:issue_id/edit' => 'issues#edit', :as => :edit_project_issue
    put 'issues/:issue_id' => 'issues#update'
    post 'issues' => 'issues#create'

    scope 'issues/:issue_id' do
      get 'comments' => 'comments#index', :as => :project_issue_comments
      get 'comments/:id/edit' => 'comments#edit', :as => :edit_project_issue_comment
      put 'comments/:id' => 'comments#update', :as => :project_issue_comment
      post 'comments' => 'comments#create'
    end
  end
end
