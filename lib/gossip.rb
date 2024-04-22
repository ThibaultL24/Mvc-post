require 'csv'

class Gossip
  attr_accessor :author
  attr_accessor :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [author, content]
    end
  end

  def self.all
    all_gossips = []

    CSV.foreach('./db/gossip.csv') do |row|
      author, content = row
      gossip = Gossip.new(author, content)
      all_gossips << gossip
    end

    all_gossips
  end

  def self.find(id)
    all_gossips = Gossip.all
    return all_gossips[id - 1] if id > 0 && id <= all_gossips.length
    nil
  end
end
