class Issues::Label < ActiveRecord::Base
  attr_accessible :color, :name, :project_id, :project

  belongs_to :project

  validates :name, :color, :project, :presence => true
end
