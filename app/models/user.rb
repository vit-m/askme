require 'openssl'

class User < ApplicationRecord
  # параметры работы модуля шифрования паролей
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_CHECK = /\A\w+\z/

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :password, confirmation: true, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, length: { maximum: 40 }, format: { with: USERNAME_CHECK }

  before_validation :downcase_attributes
  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email) # находим кандидата по email

    # сравнивается password_hash
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  private

  def encrypt_password
    if self.password.present?
      # создаём т.н. "соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # создаём хэш пароля - длинная уникальная строка, из которой невозможно восстановить пароль
      self.password_hash = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  def downcase_attributes
    username&.downcase!
    email&.downcase!
  end
end
