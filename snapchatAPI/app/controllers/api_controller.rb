class ApiController < ApplicationController

	def start
		option = params[:option]
		res = {error: 'false', data: ''}
		email = params[:email]
		password = params[:password]
		token = params[:token]
		id = params[:id]
		oldPassword = params[:oldPassword]
		password = params[:password]
		duration = params[:temps].to_i
		recipient_id = params[:u2]
		file = params[:file]

		if option == 'inscription'
			checkMail = User.find_by email: email

			return sendError(email + ' is not a valid email') if isEmail(email) == nil
			return sendError('password too short') if password.length < 4
			return sendError('email already used') if checkMail != nil 

			userData = request.POST
			userData[:token] = makeToken()
			user = User.new(userData)
			user.save

			res[:data] = {id: User.last.id}
			sendJson(res)

		elsif option == "connexion"

			user = User.find_by(email: email, password: password)
			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid password'
				return sendJson(res)
			end	
			
			user[:token] = makeToken()
			user.save
			res[:data] = {id: user.id, token: user.token}

			sendJson(res)

		elsif option == 'toutlemonde'

			user = User.find_by(email: email, token: token)
			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'
				return sendJson(res)
			end	

			usersId = User.all.pluck(:id)
			res[:data] = usersId
			sendJson(res)

		elsif option == 'image'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'
				return sendJson(res)
			end

			return sendError('Duration must be between 1 and 20') if duration < 1 || duration > 20
			return sendError('File must be a jpg image') if file.content_type != 'image/jpeg'

			ids = params[:u2].split(',').map(&:strip)
			ids.each do |v|
				return sendError('user '+v+' does not exists') if !User.exists?(v)
			end

			fileName = makeToken()
			if !file.nil?
				p 'ok'
				File.open(Rails.root.join('public', 'uploads', fileName), 'wb') do |file|
					file.write(file.read)
				end
			else
				return sendError('Upload failed')	
			end

			ids.each do |v|
				snap = Snap.new
				snap[:sender_id] = user.id
				snap[:recipient_id] = v
				snap[:duration] = duration
				snap[:file] = "http://10.34.1.226/uploads/" + fileName +".jpg"
				snap[:seen] = 0
				snap.save
				p snap
			end

			sendJson(res)


		elsif option == 'newsnap'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			res[:data] = Snap.where(recipient_id: user.id, seen: 0)
			sendJson(res)

		elsif option == 'vu'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			snap = Snap.find_by(id: id, recipient_id: user.id)

			if snap.nil?
				res[:error] = Snap.exists?(id) ? 'invalid recipient id' : 'invalid snap id'
				return sendJson(res)
			end	

			snap[:seen] = 1
			snap.save
			res[:data] = {id: snap.id}
			sendJson(res)

		elsif option == 'userinfo'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			return sendError('This user does not exists') if !User.exists?(id)	

			userinfo = User.find(id) 
			info = {id: userinfo.id, email: userinfo.email}
			res[:data] = info
			sendJson(res)

		elsif option == 'changepassword'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			return sendError('invalid password') if user.password != oldPassword	
			return sendError('password too short') if password.length < 4
			
			user[:password] = password
			user.save		
			sendJson(res)

		elsif option == 'addfriend'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			return sendError('This user does not exists') if !User.exists?(id)
			return sendError("You can't add yourself as friend") if id.to_i == user.id	
			
			friend = Friend.new
			friend[:user_id1] = user.id
			friend[:user_id2] = id
			friend[:accepted] = 0
			friend.save
			sendJson(res)

		elsif option == 'acceptfriend'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			return sendError('This user does not exists') if !User.exists?(id)
			return sendError("You can't add yourself as friend") if id.to_i == user.id	
			
			friend = Friend.find_by(user_id1: id, user_id2: user.id)

			return sendError("This user didn't send you a friend request") if friend.nil?
			
			friend[:accepted] = 1
			friend.save
			sendJson(res)

		elsif option == 'removefriend'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			return sendError('This user does not exists') if !User.exists?(id)
			return sendError("You can't add yourself as friend") if id.to_i == user.id	
			
			friend = Friend.find_by(user_id1: id, user_id2: user.id) || Friend.find_by(user_id1: user.id, user_id2: id)
			return sendError("This user didn't send you a friend request") if friend.nil?
			
			friend.delete
			sendJson(res)

		elsif option == 'friendrequest'
			user = User.find_by(email: email, token: token)

			if user == nil
				checkMail = User.find_by email: email
				res[:error] = checkMail.nil? ? 'invalid email' : 'invalid token'	
				return sendJson(res)
			end

			request = Friend.where(user_id2: user.id, accepted: 0).pluck(:user_id1)
			res[:data] = request
			sendJson(res)			

		end	
	end

	def sendJson(arr)
		respond_to do |format|
			format.json  { render :json => arr.to_json }
			format.html { render :start }
		end
	end	

	def makeToken
		return Digest::SHA1.hexdigest([Time.now, rand].join)
	end	

	def isEmail(str)
		return str.match( /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i) 
	end

	def sendError(error)
		res = {error: error, data: ''}
		respond_to do |format|
			format.json  { render :json => res }
			format.html { render :start }
		end
	end	

	def test
		uploaded_io = params[:file]
		fileName = makeToken()
		if !uploaded_io.nil?
			p 'ok'
			File.open(Rails.root.join('public', 'uploads', fileName), 'wb') do |file|
				file.write(uploaded_io.read)
			end
		end
		respond_to do |format|
			format.html { render :test }
		end
	end	

end
