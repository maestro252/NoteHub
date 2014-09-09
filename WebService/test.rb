class Foo
    attr_accessor :repeat
    @repeaters = {
        daily: 0,
        weekly: 2,
        monthly: 4,
        bimonthly: 8,
        trimonthly: 16,
        semiannual: 32,
        annual: 64
    }

    def repeat=(arg)
        index = @repeaters[arg]

        if index.nil?
          raise 'Not route for this repeat'
        end

        @repeat = 1
        @repeat <<= index
    end
    
    def repeat
        @repeaters[Math.log2 @repeat]
    end
end

a = Foo.new

a.repeat = :annual

puts a
puts a.repeat