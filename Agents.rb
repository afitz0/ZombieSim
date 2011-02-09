# 3D coordinate system. Imagine, for example, that z = 0 is street level, 
# z = -1 is a basement/subway, z = 1 is first floor of a multi-story building.
class Coor3D
	attr_accessor :x, :y, :z

	def initialize(x,y,z)
		@x, @y, @z = x, y, z	
	end

	def to_s
		"(#@x,#@y,#@z)"
	end

	def ==(o)
		if o.is_a? Coor3D
			o.x == @x && o.y == @y && o.z == @z
		else
			false
		end
	end
end

# All zombies, humans, wild animals, etc. are derived from an Agent.
class Agent
	attr_reader :energy, :health

	def initialize(coor)
		@energy   = 100
		@health   = 100
		@location = coor
	end

	def eat
		@engery += 1
	end

	def to_s
		"E: #@energy; H: #@health; Location: #{@location.to_s}"
	end
end

class Zombie < Agent
	@@count = 0

	def initialize(coor)
		super
		@@count += 1
	end
end

class Human < Agent
	attr_reader :happiness
	@@count = 0

	def initialize(coor)
		super
		@happiness = 100
		@@count   += 1
	end
end
