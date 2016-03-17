class ChirpsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def create
    @chirp = current_user.chirps.build(chirp_params)
    authorize @chirp
    if @chirp.save
      flash[:success] = 'Message created!'
      redirect_to timeline_url
    else
      @chirps = []
      render 'static_pages/timeline'
    end
  end

  def destroy
    @chirp = Chirp.find(params[:id])
    authorize @chirp
    @chirp.destroy
    redirect_to timeline_url
  end

  private
    def chirp_params
      params.require(:chirp).permit(:content)
    end
end
