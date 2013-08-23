class Game < ActiveRecord::Base

  belongs_to :boxing 
  has_many :bets
 
  attr_accessible :closeTime, :description, :gameTime, :score1, :score2, :score3, :typescore, :numscore, :numpoint, :closed, :boxing_id

  def userbet(user)
  	self.bets.where(:user_id => user).first
  end
end
