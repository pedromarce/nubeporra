class StaticPagesController < ApplicationController
  before_filter :authenticate_user!
  def home
  	@games = Game.all
  end
end
