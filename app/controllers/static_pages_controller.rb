class StaticPagesController < ApplicationController
  def timeline
    @chirps = Chirp.latest.paginate(page: params[:page])
  end
end
