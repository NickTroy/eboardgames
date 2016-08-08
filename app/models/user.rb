class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
