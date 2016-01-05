class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	has_many :voteposts
	has_many :votecoms

	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
 	PHONE_REGEX= /\A[0-9]/i
 	validates :name, :presence => true, :length =>{:in=>2..40}
  	validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  	validates :mobile, :presence=>true, :uniqueness => true,:length =>{:in=>10..10}, :format=>PHONE_REGEX
  	validates :password,:presence => true,:length =>{:in=>6..200},:on => :create
	validates_presence_of :gender,:salt

	def self.create_with_password(name,mobile,email,gender,password)

		salt = SecureRandom.hex
		password_hash = self.generate_hash(password,salt)
		
		self.create(
			name: name,
			mobile: mobile,
			email: email,
			gender: gender,
			salt: salt,
			password: password_hash
		)
	end

	def verify_password(password)
		self.password == User.generate_hash(password,self.salt)
	end

	def self.generate_hash(password,salt)
		digest = OpenSSL::Digest::SHA256.new
		digest.update(password)
		digest.update(salt)
		digest.to_s
	end
end