class ProjectsController < ApplicationController

  def index
    @projects = StudentProject.all
    
    #get the filter year and category data
    @year=params[:year]
    @category=params[:category]
  end

  def new
    # @students = Student.all

    if session[:user_id] != nil
      @user = User.find(session[:user_id]) 
      if @user.acctype == "coordinator" 
        @student_project = StudentProject.new
        @student = Student.new
        3.times { @student_project.students.build }
      else
        flash[:notice] = "Please Login as a coordinator to edit a past project"
        redirect_to :login
      end
      else
        flash[:notice] = "Please Login to edit a past project"
        redirect_to :login
    end 
  end

  def create
    @student_project = StudentProject.new(project_params)
    if @student_project.save
      
      #check IDarray is set or not
      if session[:IdArray]=0
             redirect_to pastproject_management_path, :notice => "Project created" 
    else
             redirect_to :index, :notice => "Project created" 
    end

    else
      render :new
    end
  end

  def project_params
    params.require(:student_project).permit(:title, :summary, :image, :client, :client_image, :category, :year, :client_summary, :client_link, 
    students_attributes: [:id,:name, :email, :studentID, :course])
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

     
    def edit
       if session[:user_id] != nil
          @user = User.find(session[:user_id]) 
        if @user.acctype == "coordinator" 
      #get the project's ID here
      @ProjectID = params[:id]
      @Projects = StudentProject.all

      #get the specifc project
      @theProject=@Projects.find(@ProjectID)
      #get all students worked in this project
      @students=@theProject.students.all
      else
          flash[:notice] = "Please Login as a coordinator to edit a past project"
         redirect_to :login
      end
         else
       flash[:notice] = "Please Login to edit a past project"
         redirect_to :login
       end                                                                                   
    end

  def update
                                                          
    	#get the updated project ID
    	if params[:id] !=nil
                                                                                                                                                                                                                                                                                                                                                                                  
      		@updateProject=StudentProject.find(params[:id])
     		 #get all students worked in this project
      		@students=@updateProject.students.all
      
     		 #update the attributes without save to DB yet
      		@updateProject.attributes=project_params
      		#save to DB      	
      	   	@updateProject.save
      		#check if there any change
      		#if @updateProject.changed? ==false 
      		#	 flash[:notice] ="There is no any change, please edit again"
         	#	redirect_to :edit
      		#else

      		#end      
    	end                                                                                                                                                                                                        
  end

def unchanged
end

def destroy
    if session[:user_id] != nil
          @user = User.find(session[:user_id]) 
        if @user.acctype == "coordinator" 
         	 #get the project's ID here
 	 	@ProjectID = params[:id]
      	@Projects = StudentProject.all

  		#get the specifc project
  		@theProject=@Projects.find(@ProjectID)
  
        else
          	flash[:notice] = "Please Login as a coordinator to edit a past project"
        	 redirect_to :login
      	end
     else
       flash[:notice] = "Please Login to edit a past project"
         redirect_to :login
     end    
  
end

def delete
  if params[:id] !=nil
     StudentProject.destroy(params[:id])
  end
end

def addstudent
        if params[:id] != nil
                  @theStudent = Student.new
                  @theProject= StudentProject.find(params[:id]) 
         end                                                                                                                                                                                              
end
                                                                                                                                                                                                      


  def addstudent_create
     @student = Student.new(student_params)
    if @student.save == false
      flash[:notice] = "Invalid Input"
      redirect_to student_new_path
       end
   end

def info
end


def search                                                                                                                                                                                                
         #redirect to student's search funtion  if related classify is selected
        if (params[:classify].downcase=="name" )|| (params[:classify].downcase=="student id" ) || (params[:classify].downcase=="course" ) || (params[:classify].downcase=="email" )
                 redirect_to  student_search_path(:classify=>params[:classify], :search=>params[:search])                                                                                                                                                                                              
       else    

       #fetch the searhed results here                                                                                                                                                                                                
      @searchVariable = StudentProject.search(params[:classify], params[:search])
      #handle empty search
      if @searchVariable.blank?
                 redirect_to  action:'notfound'                                                                                           
      end  
      end         
end         
 
def notfound 
                                                                                                   
end               

  def contact
  end
  
  def management
        #intialize sessions here
        session[:IdArray]=0

        @Projects = StudentProject.all
  end
  
  def managehandle
        #reset sessions 
        session[:IdArray]=nil
        session[:index_value]=nil

        #get all selected pastProjects ID array first
        @EditArray=params[:choose]
      
        #check the array is valid or not
         if @EditArray !=nil 
                #trim the array without "ticked" element
                if @EditArray.first=="ticked"
                      @EditArray.delete_at(0)              
                 end         
                  
                  if params[:commit]=="Edit"  
                              #go to multiple edit page with project ID arrays parameters and an initial index value
                              redirect_to pastproject_multiedit_path(:editArray=> @EditArray, :index=>0)
                        elsif params[:commit] =="Remove"
                             redirect_to pastproject_multiremove_path(:editArray=> @EditArray)
                        end        
          else
                        flash[:notice] = "Tick at least one box in order to edit"
                        redirect_to pastproject_management_path 
         end
  end
  
  def multiedit          
          #fetch the projects Id array and index value
          @EditArray=params[:editArray]
          
          #store project ID array and index value into session 
          session[:IdArray]=@EditArray
          
          if @EditArray!=nil             
            
                    if params[:commit]=="previous"
                          #find the related projects index here
                          @index=params[:index].to_i-1
                        
                        #make sure the index is not out of range                        
                        if @index<0
                             @index=0
                       end
                      @ID=@EditArray.at(@index).to_i              
          elsif params[:commit]=="next"
                      #find the related projects index here
                      @index=params[:index].to_i+1
                      #make sure the index is not out of range                        
                        if @index>@EditArray.size-1
                              @index=@EditArray.size-1
                        end
                      @ID=@EditArray.at(@index).to_i
           else                        
                      @ID=@EditArray.at( session[:index_value]).to_i
            end
           
           #store index value 
           session[:index_value]=@index

         #get the specific project
         @theProject=StudentProject.find(@ID)
          
          else
                redirect_to action: 'management'  
          end 
  end
  
  def multiupdate
          #fetch the projects Id array from session
           @EditArray=session[:IdArray]
           @index=session[:index_value]
           
           #get the project ID from hidden field in edit_form
           @id=params[:student_project]["projectID"]
                                                                                                                                                                                                                                                                                                                                                                           
          @updateProject=StudentProject.find(@id)
         #get all students worked in this project
          @students=@updateProject.students.all
      
         #update the attributes without save to DB yet
          @updateProject.attributes=project_params
          #save to DB       
            @updateProject.save
            
            redirect_to pastproject_multiedit_path(:editArray=> @EditArray, :index=>@index)  
end
  
    def multiremove
       #fetch the projects Id array
        @EditArray=params[:editArray]
      
      #delete all chose records
          @EditArray.each do |array|
                @find=StudentProject.find(array.to_i)            
                 StudentProject.destroy(@find)
        end
      
        redirect_to pastproject_management_path
  end
                                                                                 
end
