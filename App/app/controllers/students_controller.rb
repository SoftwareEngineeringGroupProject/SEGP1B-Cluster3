class StudentsController < ApplicationController
     def new
          # @students = Student.all
         @theStudent = Student.new
 
     end

  def create
         #add the new student to pastProjects
      @theProject= StudentProject.find(params[:id]) 
      @save=@theProject.students.new(student_params)    
    if @save.save == false
      flash[:notice] = "Invalid Input"
      redirect_to student_new_path
    end
  end                                                                                                                                                                                        
                                                                                                                                                                                                        
           def delete
                             if params[:id] !=nil
                                      #get the project id before destory                                                                                                                                                                                                                                                                                                                                                                                    
                                     @projectID= Student.find(params[:id]).student_project_id
                                     
                                     Student.find(params[:id]).destroy
                                     
                                     redirect_to edit_path(@projectID)
                              end                                                            
           end
           
           
           def edit
                      if params[:id] !=nil                                                                                                                                                                                     
                                     #@s=Student.find(params[:id]).update(student_params)
                                     #@s.save
                                     @theStudent=Student.find(params[:id])
                        end      
                        @a=request.GET                                                                                     
           end  
           
               def update
                      if params[:id] !=nil                                                                                                                                                                                     
                                     #@s=Student.find(params[:id]).update(student_params)
                                     #@s.save
                                     @theStudent=Student.find(params[:id])
                                     @theStudent.update(student_params)  
                       end                                                                                           
           end   
           
   def student_params
          params.require(:student).permit(:name, :email, :studentID, :course)
  end                                                                                                                                                                                            
end
