class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model

  has_many :bets

  attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :timezone
  # attr_accessible :title, :body

  def numpoints
    self.bets.reduce(0) { |points,bet| bet.scored? ? points += bet.game.numpoint : points }
  end  

end
