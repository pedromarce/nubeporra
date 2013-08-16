class Scoretypevalue < ActiveRecord::Base
  belongs_to :scoretype
  attr_accessible :value
end
