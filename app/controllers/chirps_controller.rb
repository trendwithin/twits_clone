class ChirpsController < ApplicationController
  before_action :authenticate_user!
  def create
    @chirp = current_user.chirps.build(chirp_params)
    if @chirp.save
      flash[:success] = 'Message created!'
      redirect_to timeline_url
    else
      render 'static_pages/timeline'
    end
  end

  def destroy
  end

  private
    def chirp_params
      params.require(:chirp).permit(:content)
    end
end
