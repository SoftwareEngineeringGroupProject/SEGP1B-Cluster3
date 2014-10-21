include ActionView::Helpers::AssetTagHelper
class ProjectsController < ApplicationController

  def index
    @projects = StudentProject.all
    # @groups = Group.all
  end

  def new
    # @students = Student.all
    @student_project = StudentProject.new
    @student = Student.new
    3.times { @student_project.students.build }
  end

  def create
    @student_project = StudentProject.new(project_params)
    if @student_project.save
      redirect_to :index, :notice => "Project created"
    else
      redirect_to :new
    end
  end

  def project_params
    params.require(:student_project).permit(:title, :summary, :image, :client, :client_image, :category, :year, students_attributes: [:name, :email, :studentID, :course])
  end

  def show
    #get the project's ID here
      @ProjectID = params[:id]
      @Projects = StudentProject.all

      #get the specifc project
      @theProject=@Projects.find(@ProjectID)
      #get all students worked in this project
      @students=@theProject.students.all

      #go to 404 page if project cannot be found
      rescue ActiveRecord::RecordNotFound
        redirect_to "/404"
  end

  # def edit

  #  if session[:user_id] != nil
         #get the project's ID here
     #    @ProjectID = params[:id]
        # @Projects = StudentProject.all

         #get the specifc project
         #@theProject=@Projects.find(@ProjectID)
    #else
       #  flash[:notice] = "Please Login to edit a past project"
         #redirect_to :login
    #end

  #end
     
    def edit
      #get the project's ID here
      @ProjectID = params[:id]
      @Projects = StudentProject.all

      #get the specifc project
      @theProject=@Projects.find(@ProjectID)
      #get all students worked in this project
      @students=@theProject.students.all
    end

  def update
                                                          
    #get the updated project ID
    if params[:id] !=nil
                                                                                                                                                                          
      @updateProject=StudentProject.find(params[:id])
      #get all students worked in this project
      @students=@updateProject.students.all
      #update the attributes without save to DB yet
      @updateProject.attributes= params[:student_project].permit(:title, :summary, :image, :client, :client_image, :category, :year, 
      students_attributes: [:name, :email, :studentID, :course])

      #check the project is updated or not, if not, redirect to unchanged page
      @a= @updateProject.changed?
      if  @a !=true                                                                                                                                         
                        redirect_to  action:'unchanged'                                                   
      end
      #save to DB here
      @updateProject.updated_at=Time.now
       @updateProject.save    

      #check if a student is deleted
      if params[:commit]=='-'
              @c=params[:students]                                                                                    
      end           
    end                                                                                                                                                                                                        
  end

def unchaned
end

     #def destroy

        #  if session[:user_id] != nil
           #    #get the project's ID here
              # @ProjectID = params[:id]
              # @Projects = StudentProject.all

               #get the specifc project
              # @theProject=@Projects.find(@ProjectID)
          ##  flash[:notice] = "Please Login to edit a past project"
             #  redirect_to :login
          #end
    # end
def destroy

  #get the project's ID here
  @ProjectID = params[:id]
  @Projects = StudentProject.all

  #get the specifc project
  @theProject=@Projects.find(@ProjectID)
end

def delete
  if params[:id] !=nil
     StudentProject.destroy(params[:id])
  end
end

def info
end


def search
      @searchVariable = StudentProject.search(params[:classify], params[:search])
      
      if @searchVariable.empty?
                 redirect_to  action:'notfound'                                                                                           
      end
end         
 
def notfound 
                                                                                                   
end               

  def contact
  end

                                                                                 
end
