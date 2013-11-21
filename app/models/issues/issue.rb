module Issues
  class Issue < ActiveRecord::Base
    attr_accessible :title, :description, :user_id, :user, :project_id, :project

    validates :title, :user, :project, :presence => true

    belongs_to :user
    belongs_to :project

    before_create :set_issue_id

    private

    def set_issue_id
      # FIXME: this is a very naive and unstable way
      self.issue_id = Issue.where(:project_id => project_id).count + 1
    end
  end
end
