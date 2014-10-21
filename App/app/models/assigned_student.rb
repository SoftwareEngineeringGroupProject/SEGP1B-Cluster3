class AssignedStudent < ActiveRecord::Base
  belongs_to :project
  validate :studentID, :presence => true, :uniqueness => true, :format => /[a]{1}[0-9]{7}/
  validate :project_id, :presence => true
  validate :group_name, :presence => true
end
