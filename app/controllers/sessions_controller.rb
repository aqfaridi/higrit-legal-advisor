class SessionsController < ApplicationController
	def new 
	end

	def create 
		@email = params[:session][:email]
		@password = params[:session][:password]

		user = User.where(email: @email).first
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

	def destroy
		session[:signed] = false
		redirect_to '/home'
	end
end
