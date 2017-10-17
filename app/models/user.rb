class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create_commit {MessageBroadcastJob.perform_now self}

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "48x48>" }, :default_url => "/images/avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
