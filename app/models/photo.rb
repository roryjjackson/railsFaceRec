class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  # def image_url
  #   if photo.attached?
  #     Rails.application.routes.url_helpers.url_for(photo.variant(resize: "400x400", host: "http://localhost:3000/"))
  #   end
  # end


end
