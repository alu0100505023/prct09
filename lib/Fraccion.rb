require 'gcd.rb'
class Fraccion
        include Comparable

        attr_reader :n, :d
        def initialize (n,d)
                @n=n
                @d=d
        end

        def to_s
                
		"#{@n}/#{@d}"                
        end
        def min 
                a=gcd(@n,@d)

                @n = @n/a
                @d = @d/a

                if gcd(@n, @d) > 1
                        self.min
                end
        end

        def getn
                return @n
        end
        
        def getd
                return @d
        end
        
        def to_f
                #puts "Flotante: #{@n.to_f/@d.to_f}"
                "#{@n.to_f/@d.to_f}"
		#f4 = Fraccion.new(@n.to_f, @d.to_f)
		#return f4
        end

        def abs
                n = @n
                d = @d

                if @n < 0
                        n = -@n
                end

                if @d < 0
                        d = -@d
                end
                Fraccion.new(n, d)
        end

        def reciprocal
                Fraccion.new(@d,@n)
        end
        
        def opuesto
                Fraccion.new(-@n,@d)
        end
        def + (other)
                if other.instance_of?Fixnum
                        n=(@n*1+(@d*other))
                        d=(@d*1)
                        
                else
                        n=(@n*other.d)+(@d*other.n)
                        d=(@d*other.d)
                end
                #"#{f4.n/f4.d}"
                f4=Fraccion.new(n,d)
                f4.min
                return f4
        end

        def - (other)
               if other.instance_of?Fixnum
                        n=(@n*1-(@d*other))
                        d=(@d*1)
                        
                else
                        n=(@n*other.d)-(@d*other.n)
                        d=(@d*other.d)
                end
                #"#{f4.n/f4.d}"
                f4=Fraccion.new(n,d)
                f4.min
                return f4
        end

        def * (other)
                if other.instance_of?Fixnum
								other = Fraccion.new(other,1)
                        n=(@n *(other.n))
                        d=(@d*1)
                        
                else
                        n=(@n*other.n)
                        d=(@d*other.d)
        
                end
                f4=Fraccion.new(n,d)
                f4.min
                #"#{f4.n/f4.d}"
                return f4

        end
        def / (other)
                n=@n*other.d
                d=@d*other.n
                f4=Fraccion.new(n,d)
                f4.min
                "#{f4.n/f4.d}"
        end
        def <=>(other)
                self.to_f<=>other.to_f
		#self<=>other                
        end

        def coerce(other)
                return [self,other]
        end
end
