# 3D coordinate system. Imagine, for example, that z = 0 is street level, 
# z = -1 is a basement/subway, z = 1 is first floor of a multi-story building.
class Coor3D
	attr_reader :x, :y, :z

	MAX_COOR = 2

	def initialize(x,y,z)
		@x, @y, @z = x, y, z
	end

	def normalize(value)
		if value < (-1*MAX_COOR)
			value = MAX_COOR
		elsif value > MAX_COOR
			value = -1*MAX_COOR
		end

		value
	end

	def x=(val)
		@x = normalize(val)
	end
	def y=(val)
		@y = normalize(val)
	end
	def z=(val)
		@z = normalize(val)
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
	alias eql? ==

	def Coor3D.random
		x = rand(MAX_COOR*2 + 1) - MAX_COOR
		y = rand(MAX_COOR*2 + 1) - MAX_COOR
		z = rand(MAX_COOR*2 + 1) - MAX_COOR


		Coor3D.new(x,y,z)
	end

	def Coor3D.parse_str(str)
		Coor3D.new(0,0,0)
	end
end

