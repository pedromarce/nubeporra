class Game < ActiveRecord::Base

  belongs_to :scoretype
  has_many :bets
 
  attr_accessible :closeTime, :description, :gameTime, :score1, :score2, :score3, :scoretype_id, :numscore
end
