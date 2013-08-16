class Scoretype < ActiveRecord::Base
  
  has_many :Scoretypevalues

  attr_accessible :description
end
