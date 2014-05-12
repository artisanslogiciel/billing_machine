class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :confirmable, :registerable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  belongs_to :entity
  has_many :time_slices, inverse_of: :user

  def manager?
    return manager_id != nil
  end
end
