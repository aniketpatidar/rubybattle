class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts

  def full_name
    [first_name, last_name].join(' ')
  end

  def initials
    [first_name[0], last_name[0]].join()
  end

end
