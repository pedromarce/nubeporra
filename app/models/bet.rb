class Bet < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  attr_accessible :betTime, :score1, :score2, :score3

  def scored?
    return checkScored(true)
  end

  def secondscored?
    return checkScored(true)
  end

  def checkScored(closed)
    return (self.game.closed? == closed and self.game.score1 == self.score1 and (self.game.numscore < 2 or self.game.score2 == self.score2) and (self.game.numscore < 3 or self.game.score3 == self.score3)) 
  end

  def checkSecondScored(closed)
    if self.game.closed? != closed
      return false
    end
    case self.game.typescore
      when ('Futbol' or 'Fubol_Sala' or 'Hoquei' or 'Hoquei_Gel')
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
      when ('Rugby' or 'Fubol_America' or 'Handball')  
        return ((self.game.score1.to_i - self.score1.to_i).abs <= 1)
      when 'Sorteig_Champions'
        return ((self.game.score1 == self.score1) or (self.game.score2 == self.score2) or (self.game.score3 == self.score3))
      else
        return false
    end
  end

  def secondpoint(closed)
    if self.game.closed? != closed
      return 0
    end
    case self.game.typescore
      when 'Sorteig_Champions'
        return ((self.game.score1 == self.score1 ? self.game.secondpoint : 0) + (self.game.score2 == self.score2 ? self.game.secondpoint : 0) + (self.game.score3 == self.score3 ? self.game.secondpoint : 0)) 
      else
        return (checkSecondScored(closed) ? self.game.secondpoint : 0)
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
    if self.checkScored(true)
      points = self.game.numpoint
    elsif self.checkSecondScored(true)
      points = self.secondpoint(true)
    end
    points
  end

  def totalpointsopen
    points = 0
    if self.checkScored(false)
      points = self.game.numpoint
    elsif self.checkSecondScored(false)
      points = self.secondpoint(false)
    end
    points
  end

end
