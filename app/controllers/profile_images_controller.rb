class ProfileImagesController < ApplicationController
  
  def new
  end
  
  def create
    @profile_image = ProfileImage.new(profile_image_params)
    @profile_image.user_id = current_user.id
    @profile_image.save
    redirect_to profile_image_path
  end
  
  def index
    @profile_images = ProfileImage.all
  end
  
  def show
  end

  def destroy
    @profile_image = ProfileImage.find(params[:id])
    @profile_image.destroy
    redirect_to profile_images_path
  end
  
  def profile_image_params
    params.require(:profile_image).permit(:image)
  end
end
