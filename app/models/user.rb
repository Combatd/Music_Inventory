#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null

class User < ApplicationRecord
    validates :password_digest, presence: true
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password, length: { minimum: 6, allow_nil: true }

    attr_reader :password # password getter method

    after_initialize :ensure_session_token

    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token # return the session token
    end

    def password=(password) # set password
        @password = password
        # self.password_digest is a setter method defined by ActiveRecord
        self.password_digest = BCrypt::Password.create(@password)
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email) # found user
        if user.nil?
            return nil
        elsif user && user.is_password?(password)
            return user
        end
    end

    private

    def self.generate_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

end