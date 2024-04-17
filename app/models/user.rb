class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  validates :slug, uniqueness: true
  before_validation :set_slug, if: -> { slug.nil? }

  def full_name
    [first_name, last_name].join(' ')
  end

  def initials
    [first_name[0], last_name[0]].join()
  end

  private

  def set_slug
    if User.find_by(slug: full_name.parameterize)
      self.slug = full_name.parameterize + SecureRandom.hex(6)
    else
      self.slug = full_name.parameterize
    end
  end
end
