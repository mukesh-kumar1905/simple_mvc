class String
	def to_snake_case
		self.gsub("::","/").gsub(/([a-z\d])([A-Z])/,'\1_\2').	#FOOBar=>foo_bar
		gsub(/([a-z\d])([A-Z])/,'\1_\2').			#FO86oBar => fo86_o_bar		
		tr("-","_").downcase
	end
	def to_camel_case
		return self if self !~ /_/ && self =~ /[A-Z]+.*/
		split('_').map { |str| str.capitalize }.join # hi_there => HiThere
	end
end