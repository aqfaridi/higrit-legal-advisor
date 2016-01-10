class SessionsController < ApplicationController
	def new 
	end

	def create 
		@email = params[:session][:email]
		@password = params[:session][:password]

		user = User.where(email: @email)
		
		if(user.count == 0)
			render 'new'
		else
			user = user.first
			valid = user.verify_password(@password)

			if valid
				session[:signed] = true
				session[:email] = params[:session][:email]
				session[:name] = user.name
				session[:userid] = user.id
				redirect_to '/home'
			else
				#flash.now[:error] = "Invalid email/password combination."
				render 'new'
			end
		end
	end

	def destroy
		session[:signed] = false
		redirect_to '/home'
	end

	def loggedin
	  if session[:signed] == true 
	    redirect_to '/home'
	  end
	end
	helper_method:loggedin
end
