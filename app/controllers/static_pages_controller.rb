class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def timeline
    @chirps = Chirp.latest.paginate(page: params[:page])
  end
end
