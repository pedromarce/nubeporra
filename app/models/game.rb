class Game < ActiveRecord::Base

  has_many :bets
 
  attr_accessible :closeTime, :description, :gameTime, :score1, :score2, :score3, :typescore, :numscore, :numpoint, :closed
end
