module Issues

  class Issue < ActiveRecord::Base
    STATE_NEW      = 'new'.freeze
    STATE_OPEN     = 'open'.freeze
    STATE_RESOLVED = 'resolved'.freeze
    STATE_INVALID  = 'invalid'.freeze

    DEFAULT_STATE = STATE_NEW

    attr_accessible :title, :description, :state, :user_id, :user,
      :project_id, :project, :milestone_id, :milestone,
      :assignee_ids, :label_ids

    validates :title, :user, :project, :issue_id, :presence => true

    belongs_to :user
    belongs_to :project
    belongs_to :milestone

    has_many :comments, :dependent => :destroy
    has_many :issue_users, :dependent => :destroy
    has_many :assignees, :through => :issue_users, :class_name => '::User', :source => :user

    has_many :issue_labels, :dependent => :destroy
    has_many :labels, :through => :issue_labels

    before_validation :set_issue_id, :on => :create

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

    def label_candidates
      Label.where(:project_id => project_id) - labels
    end

    def creator?(user)
      self.user == user
    end

    private

    def set_issue_id
      self.issue_id = next_issue_id
    end

    def next_issue_id
      (Issue.where(:project_id => project_id).maximum(:issue_id) || 0) + 1
    end

  end

end
