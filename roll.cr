struct Dice
  property count, sides, modifier

  def initialize(@count : Int32, @sides : Int32, @modifier : Int32)
  end

  def roll
    sum = (1..@count).sum { |i| rand(@sides) + 1 }
    sum + @modifier
  end
end

def parse_die_string(input : String)
  match = /(\d+)?d(\d+)([+-]\d+)?/.match input
  if match
    count = match[1]?.nil? ? 1 : match[1].to_i
    sides = match[2]?.nil? ? 1 : match[2].to_i
    modifier = match[3]?.nil? ? 0 : match[3].to_i
    return Dice.new(count, sides, modifier)
  else
    puts "Sorry, I didn't understand \"#{input}\". Enter \"droll --help\" for formatting."
    Process.exit
  end
end

if ARGV.size == 0
  puts "Please provide a dice notation, like \"1d20\" or \"3d6 + 3\""
else
  dice = ARGV.map { |i| parse_die_string i }
  dice.each { |d| puts "#{d.roll}" }
end
