class Nbascoreapi
  include HTTParty
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  

 def matchsday(date)
#    base_uri = 'http://data.nba.com/5s/json/cms/noseason/scoreboard'
#    suffix = 'games.json' 
    base_uri = 'http://mi.nba.com/statsm/feeds/season/scoreScheduleByDate.xhtml?tz=GMT0&dst=1&locale=en&gameDateOffset='
    suffix = '&countryCode=GB' 
 #   HTTParty.get('http://mi.nba.com/statsm/feeds/season/scoreScheduleByDate.xhtml?tz=GMT0&dst=1&locale=en&gameDateOffset=0&countryCode=GB')
    HTTParty.get("#{base_uri}#{date}#{suffix}")	
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end

end