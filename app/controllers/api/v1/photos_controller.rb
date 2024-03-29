
module Api
  module V1
    class PhotosController < ApplicationController
      before_action :set_photo, only: %i[ show edit update destroy ]
      require 'httparty'
      require 'cloudinary'
      def index
        @photos = policy_scope(Photo)
      end

      def show

        authorize @photo
        @photo = Photo.find(params[:id])

        Cloudinary.config do |config|

          config.cloud_name = 'dfipoufmj'
          config.api_key = '683468962932261'
          config.api_secret = 'UPJds4t9KQm8f_KSUDWgl0XWXhY'
        end
        @url = Cloudinary::Utils.cloudinary_url(@photo.photo.key)

        @url.sub!("/image/upload/", "/image/upload/production/")

        url = "https://celebrity-face-detection.p.rapidapi.com/"
        headers = {
          "Content-Type" => "application/x-www-form-urlencoded",
          "X-RapidAPI-Key" => "1bcc9af75fmsh31aeea8c1c4f208p1aad28jsn317aa2ee3ec2",
          "X-RapidAPI-Host" => "celebrity-face-detection.p.rapidapi.com"
        }
        body = {
          "image_url" => @url
        }

        response = HTTParty.post(url, headers: headers, body: body)

        @response = JSON.parse(response.body)
      end

      def new
        @photo = Photo.new
        authorize @photo
      end

      def edit
        authorize @photo
      end

      def create
        @photo = Photo.new(photo_params)
        @photo.user = current_user
        authorize @photo

        respond_to do |format|
          if @photo.save
            format.html { redirect_to api_v1_photo_url(@photo), notice: "Photo was successfully created." }
            format.json { render :show, status: :created, location: @photo }
          else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @photo.errors, status: :unprocessable_entity }
          end
        end
      end

      def update
        authorize @photo

        respond_to do |format|
          if @photo.update(photo_params)
            format.html { redirect_to photo_url(@photo), notice: "Photo was successfully updated." }
            format.json { render :show, status: :ok, location: @photo }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @photo.errors, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @photo.destroy
        authorize @photo

        respond_to do |format|
          format.html { redirect_to api_v1_photos_url, notice: "Photo was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      private
        def set_photo
          @photo = Photo.find(params[:id])
        end

        def photo_params
          params.require(:photo).permit(:url, :photo)
        end
    end
  end
end
