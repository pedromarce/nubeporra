class Bet < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  attr_accessible :betTime, :score1, :score2, :score3

  def scored?
    return (self.game.closed? and self.game.score1 == self.score1 and (self.game.numscore < 2 or self.game.score2 == self.score2) and (self.game.numscore < 3 or self.game.score3 == self.score3)) 
  end

  def score
  	score = self.score1
  	if self.game.numscore >= 2
      score += (' - ' + self.score2)
  	end
  	if self.game.numscore >= 3
      score += (' - ' + self.score3)
    end
    score
  end

end
