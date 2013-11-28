module Issues
  module Params

    class IssueParams
      include Virtus.model

      attribute :title,        String
      attribute :description,  String
      attribute :state,        String, :default => 'new'
      attribute :milestone_id, Integer
      attribute :assignee_ids, Array[Integer]
      attribute :label_ids,    Array[Integer]
    end

  end
end
