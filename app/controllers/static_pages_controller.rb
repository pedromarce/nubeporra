class StaticPagesController < ApplicationController
  before_filter :authenticate_user!
  def home
  	@games = Game.order('"gameTime"').where(:gameTime => 5.days.ago..10.days.from_now).includes(:bets => {:game => :bets})
  	@standings = User.all.includes(:bets => {:game => :bets}).sort_by { |user| user.numpoints * -1 }
  end
end
