require "./Coor3D.rb"

# All zombies, humans, wild animals, etc. are derived from an Agent.
class Agent
	attr_reader :energy, :health

	def initialize
		@energy   = 100
		@health   = 100
	end

	def moveFrom(coor)
		to = Coor3D.parse_str(coor)

		d_x, d_y, d_z = (rand(4)-1), (rand(4)-1), (rand(4)-1)
		to.x += d_x
		to.y += d_y
		to.z += d_z

		to
	end

	def to_s
		"E: #@energy; H: #@health"
	end
end

class Zombie < Agent
	@@count = 0
	def Zombie.add
		@@count += 1
	end

	def initialize
		super
		@@count += 1
	end

	def Zombie.report
		puts "There are #@@count zombies in the world."
	end

	def to_s
		pre = super
		"Zombie ("+pre+")"
	end
end

class Human < Agent
	# % chance, after all other factors considered, human will become zombie
	# during an encounter.
	ZOMBIFICATION_CHANCE = 0.3

	@@count = 0
	def Human.rm
		@@count -= 1
	end

	def initialize
		super
		@@count   += 1
	end

	# Fighting should be a function of energy, health, number of enemies
	# (zombies) number of allies (other humans at the smae location), and
	# some dumb luck. If all of these factors combine to be less than some
	# predetermined value, then the human dies and beomces a zombie.
	#
	# Actual mechanics of that combination are up for debate. For now, just 
	# deal with Lady Luck.
	#
	# Evaluates to false if Human lost fight, true otherwise.
	def fight(zombies, humans=1)
		if rand < ZOMBIFICATION_CHANCE
			false
		else
			true
		end
	end

	def Human.report
		puts "There are #@@count humans in the world."
	end
end
