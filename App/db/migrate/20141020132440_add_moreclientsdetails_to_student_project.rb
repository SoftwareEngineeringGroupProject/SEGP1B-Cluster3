class AddMoreclientsdetailsToStudentProject < ActiveRecord::Migration
	def change
		add_column :student_projects, :client_summary, :string
		add_column :student_projects, :client_link, :string
	end
end
