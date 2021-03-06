class Boxing < ActiveRecord::Base
  has_many :games

  attr_accessible :description

 def numpoints(user)
    points = 0
    self.games.each do |game|
    	bet = game.userbet(user)
    	(points += bet.totalpoints) if bet
    end
    points
  end

end
