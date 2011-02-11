# All zombies, humans, wild animals, etc. are derived from an Agent.
class Agent
	attr_reader :energy, :health

	def initialize
		@energy   = 100
		@health   = 100
	end

	def moveFrom(coor)
		to = coor.dup

		d_x, d_y, d_z = rand(2), rand(2), rand(2)
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

	def initialize
		super
		@@count += 1
	end

	def Zombie.report
		puts "There are #@@count zombies in the world."
	end
end

class Human < Agent
	@@count = 0

	def initialize
		super
		@@count   += 1
	end

	def Human.report
		puts "There are #@@count humans in the world."
	end
end
