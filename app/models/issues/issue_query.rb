module Issues

  class IssueQuery
    include Virtus.model
    extend ActiveModel::Naming
    include ActiveModel::Conversion

    attribute :project_id,   String, :strict => true
    attribute :milestone_id, Integer
    attribute :label_ids,    Array[Integer]

    attr_reader :project

    def initialize(params, project)
      super(params)
      @project = project
    end

    def milestones
      Milestone.where(:project_id => project.id).map { |milestone| [milestone.name, milestone.id] }
    end

    def labels
      Label.where(:project_id => project.id)
    end

    def label_active?(label)
      label_ids.include?(label.id)
    end

    def persisted?
      false
    end
  end

end
