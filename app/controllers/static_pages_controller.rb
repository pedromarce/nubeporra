class StaticPagesController < ApplicationController
  before_filter :authenticate_user!
  def home
  	@games = Game.order('"gameTime"').where(:closeTime => 5.days.ago..10.days.from_now).includes(:bets => {:game => :bets})
  	@standings = User.all.includes(:bets => {:game => :bets}).sort_by { |user| user.numpoints * -1 }
  end

  def live
    api = ScoreapisController.new
    api.close_games  	
    @games = Game.order('"gameTime"').where(:gameTime => 4.hours.ago..1.minute.from_now).includes(:bets => {:game => :bets})
  	currstandings = User.all.includes(:bets => {:game => :bets}).sort_by { |user| user.numpoints * -1 }
  	currstandings.each_with_index do |user, index|
  		user.position = index
      user.openpoints = @games.reduce(0) { |openpoints, game| openpoints += (game.userbet(user) ? game.userbet(user).totalpointsopen : 0)}
      user.provpoints = user.numpoints + user.openpoints
    end
    @standings = currstandings.sort_by { |user| user.provpoints * -1}
  end
end
