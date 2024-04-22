require 'csv'

class Gossip
  attr_reader :id, :author, :content

  def initialize(id, author, content)
    @id = id
    @author = author
    @content = content
  end

  def save
    CSV.open("db/gossip.csv", "a") do |csv|
      csv << [@id, @author, @content]
    end
  end

  def self.all
    CSV.read('db/gossip.csv').map do |row|
      id, author, content = row
      Gossip.new(@id, @author, @content)
    end
  end

  def self.find(id)
    all_gossips = self.all
    all_gossips.find { |gossip| gossip.id == id }
  end
end
