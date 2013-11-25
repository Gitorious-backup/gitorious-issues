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

    has_many :comments, :dependent => :destroy
    has_many :issue_users, :dependent => :destroy
    has_many :assignees, :through => :issue_users, :class_name => 'User', :source => :user

    has_many :issue_labels, :dependent => :destroy
    has_many :labels, :through => :issue_labels

    before_create :set_issue_id, :set_default_state

    def self.sorted
      order('created_at DESC')
    end

    def to_param
      issue_id
    end

    def assignee_candidates
      project.repositories.
        flat_map(&:committerships).
        map(&:committer).
        flat_map { |committer| committer.is_a?(User) ? committer : committer.members }.
        reject { |user| assignees.include?(user) }
    end

    def update_assignees(ids)
      to_assign = ids.map { |id| User.find(id) }
      to_remove = assignees - to_assign

      to_assign.each do |user|
        assignees << user unless assignees.include?(user)
      end

      to_remove.each do |user|
        assignees.delete(user)
      end

      self
    end

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
