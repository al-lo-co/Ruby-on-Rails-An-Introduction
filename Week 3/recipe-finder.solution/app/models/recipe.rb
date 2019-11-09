class Recipe
  include HTTParty
  #ENV["FOOD2FORK_KEY"] = "7cca11667a50a78397ef6e76276de360" 
  hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'food2fork.com' 

  base_uri "http://#{hostport}/api"

  default_params key: ENV["FOOD2FORK_KEY"]
  format :json

  def self.for (keyword)
    get("/search", query: {q: keyword})["recipes"]
  end
end