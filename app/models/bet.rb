class Bet < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  attr_accessible :betTime, :score1, :score2, :score3

  def scored?
    return (self.game.closed? and self.game.score1 == self.score1 and (self.game.numscore < 2 or self.game.score2 == self.score2) and (self.game.numscore < 3 or self.game.score3 == self.score3)) 
  end

  def secondscored?
    if !self.game.closed?
      return false
    end
    case self.game.typescore
      when 'Futbol'
        return (((self.game.score1 > self.game.score2) and (self.score1 > self.score2)) or ((self.game.score1 < self.game.score2) and (self.score1 < self.score2)) or ((self.game.score1 == self.game.score2) and (self.score1 == self.score2)))
      when 'Formula1' 
        return self.game.score1 == self.score1
      when 'MotoGP' 
        return self.game.score1 == self.score1
      when 'Moto2' 
        return self.game.score1 == self.score1
      when 'Moto3'
        return self.game.score1 == self.score1
      when 'Basquet'
        return ((self.game.score1.to_i - self.score1.to_i).abs <= 2)
      when 'Sorteig_Champions'
        return ((self.game.score1 == self.score1) or (self.game.score2 == self.score2) or (self.game.score3 == self.score3))
      else
        return false
    end
  end

  def secondpoint
    if !self.game.closed?
      return 0
    end
    case self.game.typescore
      when 'Sorteig_Champions'
        return ((self.game.score1 == self.score1 ? self.game.secondpoint : 0) + (self.game.score2 == self.score2 ? self.game.secondpoint : 0) + (self.game.score3 == self.score3 ? self.game.secondpoint : 0)) 
      else
        return (self.secondscored? ? self.game.secondpoint : 0)
    end
  
  end


  def score
  	score = self.score1 if self.score1
  	if self.game.numscore >= 2
      score += (' - ' + self.score2) if self.score2
  	end
  	if self.game.numscore >= 3
      score += (' - ' + self.score3) if self.score3
    end
    score
  end

  def totalpoints
    points = 0
    if self.scored?
      points = self.game.numpoint
    elsif self.secondscored?
      points = self.secondpoint
    end
    points
  end

end
