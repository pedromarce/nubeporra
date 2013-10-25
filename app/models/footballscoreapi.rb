class Footballscoreapi
  include HTTParty
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  

  def leagues
    base_uri = 'http://www.resultados-futbol.com/scripts/api/api.php'
    key_param = '5cdb0947a37e178f340b78576e90d058'
    format_param = 'json' 
    HTTParty.get("#{base_uri}?key=#{key_param}&format=#{format_param}&req=leagues")	
  end

 def matchsday(date)
    base_uri = 'http://www.resultados-futbol.com/scripts/api/api.php'
    key_param = '5cdb0947a37e178f340b78576e90d058'
    format_param = 'json' 
    HTTParty.get("#{base_uri}?key=#{key_param}&format=#{format_param}&req=matchsday&top=true&date=#{date}")	
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