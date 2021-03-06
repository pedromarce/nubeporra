class Game < ActiveRecord::Base

  belongs_to :boxing 
  has_many :bets
 
  attr_accessible :externalid, :closeTime, :description, :gameTime, :score1, :score2, :score3, :typescore, :numscore, :numpoint, :closed, :boxing_id, :secondpoint
  
  def userbet(user)
  	self.bets.where(:user_id => user).first
  end

  def score
  	score = self.score1 if self.score1
  	if self.numscore
      if self.numscore >= 2
        score += (' - ' + self.score2) if self.score2
      end
    	if self.numscore >= 3
        score += (' - ' + self.score3) if self.score3
      end
    end
    score    
  end
  
end
