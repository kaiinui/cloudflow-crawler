require_relative 'config/aws'
require 'mechanize'
require 'cloud_flow'

domain = "http://spideringhacks.org.ua/"

@agent = Mechanize.new
flow = CloudFlow.new("crawler")

flow.on :fetch do |url|
  puts "fetching: #{url}"
  page = @agent.get url

  #############
  # DO THINGS #
  #############

  page.links.select {|l| l.include? domain}.each do |link|
    flow.fetch link.uri
  end
end

flow.fetch domain

flow.start