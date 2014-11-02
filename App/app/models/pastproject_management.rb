class PastprojectManagement < ActiveRecord::Base
    has_many :student_project
    
    accepts_nested_attributes_for :student_project, allow_destroy: true
    
end
