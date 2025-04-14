class User < ApplicationRecord
  has_secure_password # if using bcrypt
  has_many :budgets
  has_many :transactions
end

