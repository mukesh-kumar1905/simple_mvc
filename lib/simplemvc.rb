require "simplemvc/version"
require "simplemvc/controller.rb"
require "simplemvc/utils.rb"
require "simplemvc/dependencies.rb"

module Simplemvc
	class Application 
		def call(env)
			if env["PATH_INFO"] == "/"
				return [302 ,{"Location" => "/pages/about"},[]]
			end
			if env["PATH_INFO"] == "/favicon.ico"
				return [500 ,{},[]]
			end
			#env["PATH_INFO"]= "/pages/about" => PagesController.send(:about)
			controller_class,action=get_controller_and_action(env)
			controller=controller_class.new(env)
			response=controller.send(action)	
		end
		def get_controller_and_action(env)
			_,controller_name,action=env["PATH_INFO"].split("/")
			controller_name=controller_name.to_camel_case+"Controller"
			[Object.const_get(controller_name),action]
		end
		
		
	end
end
