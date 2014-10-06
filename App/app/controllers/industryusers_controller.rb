class IndustryusersController < ApplicationController
  	def new
  		@industryuser = Industryuser.new
  	end
  
	def index
		@industryusers = Industryusers.all
	end
end
