class ScoreType < ActiveRecord::Base
  
  has_many :Scoretypevalues
  has_many :Games
  has_many :Bets

  attr_accessible :description
end
