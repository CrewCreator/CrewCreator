# app/models/concerns/EmailUniqueness.rb

##-----------------------------------

class EmailUniquenessValidator < ActiveModel::Validator

  def validate(user)
    if Admin.exists?(email: user.email)
      if user.id != Admin.where(email: user.email).first.id
        user.errors.add(:email, 'Email is already taken!')
      end
    elsif Student.exists?(email: user.email)
      if user.id != Student.where(email: user.email).first.id
        user.errors.add(:email, 'Email is already taken!')
      end
    elsif Instructor.exists?(email: user.email)
      if user.id != Instructor.where(email: user.email).first.id
        user.errors.add(:email, 'Email is already taken!')
      end
    end
  end
end