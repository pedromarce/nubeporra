class StaticPagesController < ApplicationController
  before_filter :authenticate_user!
  def home
  	@games = Game.order(:gameTime).all
  end
end
