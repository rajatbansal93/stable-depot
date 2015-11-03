class ImagesController < ApplicationController

  def destroy
    Image.find(params[:id]).destroy
    render :json => {}
  end

  private

    def image_params
      params.require(:image).permit(:id)
    end

end
