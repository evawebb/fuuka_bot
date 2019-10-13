require "json"
require "open-uri"
require "uri"

def get_commands()
  [
    {
      :command => /image me (.*)/,
      :response => Proc.new do |client, data, args|
        search_response = open("https://www.googleapis.com/customsearch/v1?searchType=image&key=#{ENV["GOOGLE_SEARCH_API_KEY"]}&cx=#{ENV["GOOGLE_SEARCH_ID"]}&q=#{args[1].gsub(" ", "+")}").read
        results = JSON.parse(search_response)
        links = results["items"].map { |i| i["link"] }

        if links.size > 0
          client.say(
            channel: data.channel,
            text: links.sample
          )
        else
          client.say(
            channel: data.channel,
            text: "No results found."
          )
        end
      end
    }
  ]
end
          
