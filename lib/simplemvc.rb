require "simplemvc/version"

module Simplemvc
	class Application 
		def call(env)
			if env["PATH_INFO"] == "/"
				return [302 ,{"Loaction" => "/pages/controller"},[]]
			end
			#env["PATH_INFO"]= "/pages/about" => PagesController.send(:about)
			controller_class,action=get_controller_and_action(env)
			puts controller_class.class
			response=controller_class.new.send(action)	

			[200 , {"Content-type" =>"text/html"},[ response ]   ]
		end
		def get_controller_and_action(env)
			_,controller_name,action=env["PATH_INFO"].split("/")
			controller_name=controller_name.capitalize+"Controller"
			[Object.const_get(controller_name),action]
		end
		
		
	end
end
