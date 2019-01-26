# app/models/concerns/EmailUniqueness.rb

##-----------------------------------

class EmailUniquenessValidator < ActiveModel::Validator

  def validate(user)
    if Admin.exists?(:email => user.email) || Student.exists?(:email => user.email)
      user.errors.add(:email, 'Email is already taken!')
    end
  end

end