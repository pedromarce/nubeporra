class Bet < ActiveRecord::Base

  belongs_to :user
  belongs_to :game

  attr_accessible :betTime, :score1, :score2, :score3
end
