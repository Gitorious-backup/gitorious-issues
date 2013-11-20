module Issues
  class Issue < ActiveRecord::Base
    attr_accessible :title, :description, :user_id, :user, :project_id, :project

    validates :title, :user, :project, :presence => true

    belongs_to :user
    belongs_to :project
  end
end
