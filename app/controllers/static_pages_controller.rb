class StaticPagesController < ApplicationController
  before_filter :authenticate_user!
  def home
  	@games = Game.order('"gameTime"').where(:closeTime => 5.days.ago..10.days.from_now).includes(:bets => {:game => :bets})
  	@standings = User.all.includes(:bets => {:game => :bets}).sort_by { |user| user.numpoints * -1 }
  end

  def live
  	@games = Game.order('"gameTime"').where(:gameTime => 4.hours.ago..1.minute.from_now).includes(:bets => {:game => :bets})
  	@standings = User.all.includes(:bets => {:game => :bets}).sort_by { |user| user.numpoints * -1 }
  	@standings.each do |user|
  		user.openpoints = @games.reduce(0) { |openpoints, game| openpoints += (game.userbet(current_user) ? game.userbet(current_user).totalpointsopen : 0)}
  	end
  end
end
