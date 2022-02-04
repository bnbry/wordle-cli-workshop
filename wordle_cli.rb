require "thor"

class WordleCLI < Thor
  desc "hello NAME", "say hello to NAME"

  def hello(name)
    puts "Hello #{name}"
  end
end
