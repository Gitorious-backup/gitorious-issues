module Issues
  class Issue < ActiveRecord::Base
    STATE_NEW      = 'new'.freeze
    STATE_OPEN     = 'open'.freeze
    STATE_RESOLVED = 'resolved'.freeze
    STATE_INVALID  = 'invalid'.freeze

    DEFAULT_STATE = STATE_NEW

    attr_accessible :title, :description, :state, :user_id, :user, :project_id, :project

    validates :title, :user, :project, :presence => true

    belongs_to :user
    belongs_to :project

    before_create :set_issue_id, :set_default_state

    private

    def set_issue_id
      # FIXME: this is a very naive and unstable way
      self.issue_id = Issue.where(:project_id => project_id).count + 1
    end

    def set_default_state
      self.state ||= DEFAULT_STATE
    end
  end
end
