class Admin < ApplicationRecord
    validates_presence_of :name, :email, :password
end
