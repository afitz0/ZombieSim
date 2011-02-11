# 3D coordinate system. Imagine, for example, that z = 0 is street level, 
# z = -1 is a basement/subway, z = 1 is first floor of a multi-story building.
class Coor3D
	attr_accessor :x, :y, :z
	MAX_COOR = 100

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
	alias eql? ==

	def Coor3D.random
		x, y, z = rand(MAX_COOR), rand(MAX_COOR), rand(MAX_COOR)
		Coor3D.new(x,y,z)
	end
end

