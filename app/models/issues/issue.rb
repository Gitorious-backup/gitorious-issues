require 'gitorious/authorization'

module Issues

  class Issue < ActiveRecord::Base
    STATE_NEW      = 'new'.freeze
    STATE_OPEN     = 'open'.freeze
    STATE_RESOLVED = 'resolved'.freeze
    STATE_INVALID  = 'invalid'.freeze

    DEFAULT_STATE = STATE_NEW

    attr_accessible :title, :description, :state, :user_id, :user,
      :project_id, :project, :milestone_id, :milestone

    validates :title, :user, :project, :presence => true

    belongs_to :user
    belongs_to :project
    belongs_to :milestone

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

    def label_candidates
      Label.where(:project_id => project_id) - labels
    end

    def update_assignees(ids)
      update_collection(ids, :assignees, User)
    end

    def update_labels(ids)
      update_collection(ids, :labels, Label)
    end

    def creator?(user)
      self.user == user
    end

    private

    def set_issue_id
      # FIXME: this is a very naive and unstable way
      self.issue_id = next_issue_id
    end

    def next_issue_id
      (Issue.where(:project_id => project_id).maximum(:issue_id) || 0) + 1
    end

    def set_default_state
      self.state ||= DEFAULT_STATE
    end

    def update_collection(ids, name, model)
      collection = public_send(name)
      to_assign  = ids.map { |id| model.find(id) }
      to_remove  = collection - to_assign

      to_assign.each do |member|
        collection << member unless collection.include?(member)
      end

      to_remove.each do |member|
        collection.delete(member)
      end

      self
    end

  end

end
