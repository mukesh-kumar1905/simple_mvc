require "sqlite3"
module Simplemvc
	class Mapper
		@@db=SQLite3::Database.new File.join("db","app.db")
		@@table_name = ""
		@@model=nil
		@@mappings={}
		def save(model)
			@model=model
			if model.id
				@@db.execute("UPDATE #{@@table_name} SET #{update_record_placeholders}	 WHERE id=?",update_record_values)

			else
				@@db.execute "INSERT INTO #{@@table_name} (#{get_columns}) VALUES (#{new_record_placeholders})",new_record_values
			end
			
		end

		def update_record_placeholders
			columns=@@mappings.keys
			columns.delete(:id)
			columns.map { |col| "#{col}=?"  }.join(",")
		end
		def get_columns
			columns=@@mappings.keys
			columns.delete(:id)
			columns.join(",")
		end
		def new_record_placeholders
			(["?"]*(@@mappings.size-1)).join(',')
		end
		def get_values
			attributes=@@mappings.values
			attributes.delete(:id)
			attributes.map { |method| self.send(method)  }
		end

		def update_record_values
			values=get_values << self.send(:id)
			values
		end

		def new_record_values
			get_values
		end

		def method_missing(method,*args)
			@model.send(method)
		end
		def self.find(id)
			row=@@db.execute("SELECT #{@@mappings.keys.join(',')} FROM #{@@table_name} 	WHERE id=?",id).first
			self.map_row_to_object(row)
		end

		def self.map_row_to_object(row)
			post=@@model.new
			post.id=row[0]
			post.title=row[1]
			post.body=row[2]
			post.created_at=row[3]
			post
		end

		
		def self.findAll
			data=@@db.execute "SELECT #{@@mappings.keys.join(',')} FROM #{@@table_name}"
			data.map do |row|
				self.map_row_to_object(row)
			end
		end
		def delete(id)
			@@db.execute "DELETE FROM #{@@table_name} WHERE id= ?",id
		end
	end
end