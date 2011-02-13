# 3D coordinate system. Imagine, for example, that z = 0 is street level, 
# z = -1 is a basement/subway, z = 1 is first floor of a multi-story building.
class Coor3D
	attr_reader :x, :y, :z

	MAX_COOR = 10

	def Coor3D.randomUnit(range)
		rand(range*2 + 1) - range
	end

	def Coor3D.random
		x = randomUnit(MAX_COOR)
		y = randomUnit(MAX_COOR)
		z = randomUnit(MAX_COOR)

		Coor3D.new(x,y,z)
	end

	def Coor3D.parse_str(s)
		str = s.dup

		str.gsub!(/\(|\)/, '')
		x,y,z = str.split(',')
		x = Integer(x)
		y = Integer(y)
		z = Integer(z)

		Coor3D.new(x,y,z)
	end

	def initialize(x,y,z)
		@x, @y, @z = x, y, z
	end

	# Normalize ensures that "value" is not out of the boundaries of the world.
	# Assumes toroidal behavior.
	def normalize(value)
		if value < (-1*MAX_COOR)
			value = MAX_COOR
		elsif value > MAX_COOR
			value = -1*MAX_COOR
		end

		value
	end

	# Coordinate accessors, normalizing first
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

	def randomChange(delta)
		@x = normalize( Coor3D.randomUnit(delta) + @x )
		@y = normalize( Coor3D.randomUnit(delta) + @y )
		@z = normalize( Coor3D.randomUnit(delta) + @z )
	end

	def ==(o)
		if o.is_a? Coor3D
			@x.eql?(o.x) && @y.eql?(o.y) && @z.eql?(o.z)
		else
			false
		end
	end
	alias eql? ==

	def hash
		code = 17
		code = 37*code + @x.hash
		code = 37*code + @y.hash
		code = 37*code + @z.hash
		code
	end
end
