require "./Coor3D.rb"

class AgentList < Array
	def delete(obj)
		if obj.is_a? Human
			Human.decrement
		elsif obj.is_a? Zombie
			Zombie.decrement
		end

		super
	end
end

# All zombies, humans, wild animals, etc. are derived from an Agent.
class Agent
	attr_reader :energy, :health

	MAX_HEALTH = 100
	MAX_ENERGY = 100
	MOVE_COST  = 1

	def initialize
		@energy   = MAX_ENERGY
		@health   = MAX_HEALTH
	end

	# Returns nil if agent's energy has been expended.
	# Otherwise, return the coordinate to move to.
	def moveFrom(coor)
		if coor.is_a? Coor3D
			to = coor.dup
			to.randomChange(speedFactor)
		end

		# XXX Energy depletion as it is here results in all agents dying by
		# XXX iteration 100 and moving slowly enough that no human succumbs to
		# XXX zombification. Addition of food may solve this problem.
		#@energy -= MOVE_COST

		# If we've expended all energy, this agent need to die.
		if @energy <= 0
			nil
		else
			to
		end
	end

	def to_s
		"E: #@energy; H: #@health"
	end

	# Generate a factor in the range 0...10 based on current stats.
	def speedFactor
		Integer((@energy + @health) / (MAX_HEALTH + MAX_ENERGY)) * 10
	end
end

class Zombie < Agent
	@@count = 0

	def Zombie.decrement
		@@count -= 1
	end

	def initialize
		super
		@@count += 1

		# Zombies, by nature, have no health and cannot gain health. This also
		# serves to cripple their movement speed.
		# -----
		# NOTE Value of 0 relies on speedFactor being additive not multiplicative,
		# NOTE otherwise the zombie will never go anywhere.
		@health = 0
		@health.freeze
	end

	def Zombie.report
		puts "There are #@@count zombies in the world."
	end
end

class Human < Agent
	# % chance, after all other factors considered, human will become zombie
	# during an encounter.
	ZOMBIFICATION_CHANCE = 0.3

	@@count = 0
	def Human.decrement
		@@count -= 1
	end

	def initialize
		super
		@@count   += 1
	end

	# Fighting should be a function of energy, health, number of enemies
	# (zombies) number of allies (other humans at the same location), and
	# some dumb luck. If all of these factors combine to be less than some
	# predetermined value, then the human dies and becomes a zombie.
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
