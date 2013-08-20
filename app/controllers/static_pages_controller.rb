class StaticPagesController < ApplicationController
  before_filter :authenticate_user!
  def home
  	@games = Game.order('"gameTime"').where(:gameTime => 2.days.ago..10.days.from_now)
  	@standings = User.all.sort_by { |user| user[:numpoints]}
  end
end
