module Issues
  class Issue < ActiveRecord::Base
    attr_accessible :title, :description, :user_id, :project_id

    validates :title, :user, :project, :presence => true

    belongs_to :user
    belongs_to :project
  end
end
