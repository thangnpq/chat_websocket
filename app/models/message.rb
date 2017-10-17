class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  has_attached_file :image, styles: { medium: "300x300>", thumb: "120x120>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  after_create_commit { BroadcastMessageJob.perform_later self  }

  def to_jq_upload
    {
      "name" => read_attribute(:image_file_name),
      "size" => read_attribute(:image_file_size),
      "url" => image.url(:medium)
    }
  end
end
