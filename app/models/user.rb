class User < ApplicationRecord
  has_secure_password
  has_many :words
  has_many :feelings, through: :words
  accepts_nested_attributes_for :words
end
