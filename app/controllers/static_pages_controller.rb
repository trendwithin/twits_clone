class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def timeline
    @chirps = Chirp.latest.paginate(page: params[:page])
    @chirp = current_user.chirps.build
  end
end
