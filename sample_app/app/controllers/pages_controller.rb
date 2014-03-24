class PagesController < Simplemvc::Controller
	def about
		render :about,name: "Mukesh" ,last_name:"Kumar"
	end
	def tell_me
		@name="Mukesh"
	end 
	def index
	end
end
