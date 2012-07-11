require 'digest/sha2'
class User < ActiveRecord::Base
	#setter del password 	
	def password=(pass)
		salt = [Array.new(6){rand(256).chr}.join].pack("m").chomp
		self.password_salt, self.password_hash = salt, Digest::SHA256.hexdigest(pass + salt)
	end

	#usuario autenticado
	def self.authenticate(username, password)
		user = User.find(:first, :conditions => ['username = ?' , username])
		
		if user.blank? || Digest::SHA256.hexdigest(password + user.password_salt) != user.password_hash
			raise "Username or password invalid"
		end
		user
	end
	

end
