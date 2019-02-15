class User < ActiveRecord::Base
    attr_accessor :password
    belongs_to :role
    
    #before_validation :downcase_name, :downcase_email
    #VALID_NAME_REGEX = /\A[a-zA-Z0-9]{1,50}\z/
    #validates :name, presence: true, format: {with: VALID_NAME_REGEX, message: "doesn't support this username format!"}, length: {maximum: 50}, uniqueness: true
    #VALID_EMAIL_REGEX = /\A[^\s@]+@((?!gmail|yahoo|outlook).)+\.[^\s@]+\z/
    #validates :email, presence: true, format: {with: VALID_EMAIL_REGEX, message: "doesn't support this email format!"}, uniqueness: true
    #validates :password, confirmation: true    
    before_create :encrypted_password

    def has_password?(submitted_password)
        password_digest == encrypt(submitted_password)
    end

    def self.authenticate(name, submitted_password)
        user = User.find_by(name: name)
        if user.nil?
            user = User.find_by(email: name)
        end
        return nil if user.nil?
        return user if user.has_password?(submitted_password)
    end

    # def self.isUsernameNotExisted?(name, email)
       
    #     user = User.find_by(name: name)
    #     email = User.find_by(email: email)
    #     # if user.nil?
    #     #     user = User.find_by(email: email)
    #     # end
    #     return true, "" if user.nil?
    #     return false, "Username has been used, please try another name !!!" unless user.nil?
        
    # end
    
    def downcase_name
        self.name.downcase!
    end

    def downcase_email
        self.email.downcase!
    end

    #update the users when they activated account
    def validate_email
        self.isActivated = true
        self.key = nil
    end

    # random generate string for key (base64)
    def set_key
        if self.key.blank?
            self.key = SecureRandom.urlsafe_base64.to_s
        end
    end
    private
        def encrypted_password
            #generate a unique salt if it is a new user
            self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}") if self.new_record?

            #encrypt the password and store that in the ecrypted_password field
            self.password_digest= encrypt(password)
        end

        def encrypt(pass)
            Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
        end  

        
        
end
