Issues::Engine.routes.draw do
  scope 'projects/:project_id' do
    scope 'issues' do
      get 'labels' => 'labels#index', :as => :project_issue_labels
      get 'labels/new' => 'labels#new', :as => :new_project_issue_label
      post 'labels' => 'labels#create'
      put 'labels' => 'labels#update'
      get 'labels/:id' => 'labels#show', :as => :project_issue_label
      delete 'labels/:id' => 'labels#destroy'
    end

    scope 'issues' do
      get 'milestones' => 'milestones#index', :as => :project_issue_milestones
      get 'milestones/new' => 'milestones#new', :as => :new_project_issue_milestone
      post 'milestones' => 'milestones#create'
      put 'milestones' => 'milestones#update'
      get 'milestones/:id' => 'milestones#show', :as => :project_issue_milestone
      delete 'milestones/:id' => 'milestones#destroy'
    end

    get 'issues' => 'issues#index', :as => :project_issues
    get 'issues/new' => 'issues#new', :as => :new_project_issue
    get 'issues/:issue_id' => 'issues#show', :as => :project_issue
    get 'issues/:issue_id/edit' => 'issues#edit', :as => :edit_project_issue
    post 'issues' => 'issues#create'
    put 'issues/:issue_id' => 'issues#update'

    scope 'issues/:issue_id' do
      get 'comments' => 'comments#index', :as => :project_issue_comments
      get 'comments/:id/edit' => 'comments#edit', :as => :edit_project_issue_comment
      put 'comments/:id' => 'comments#update', :as => :project_issue_comment
      post 'comments' => 'comments#create'
    end
  end
end
