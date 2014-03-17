require "simplemvc/version"

module Simplemvc
	class Application 
		def call(env)
			[200 , {"Content-type" =>"text/html"},[ "hello"]   ]	
		end
		
		
	end
end
