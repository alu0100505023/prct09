require 'fraccion.rb'

class SparseVector
    attr_reader :vector

    def initialize(h = {})
        @vector = Hash.new(0)
        @vector = @vector.merge!(h)
    end

    def [](i)
        @vector[i]
    end

    def to_s
        @vector.to_s
    end
end

class SparseMatrix

    attr_reader :matrix

    def initialize(h = {})
        @matrix = Hash.new({})
        for k in h.keys do
            @matrix[k] = if h[k].is_a? SparseVector 
				h[k]
        		else
           		   @matrix[k] = SparseVector.new(h[k])
    			end
        end
    end

    def [](i)
        @matrix[i]
    end

    def col(j)
        c = {}
        for r in @matrix.keys do
            c[r] = @matrix[r].vector[j] if @matrix[r].vector.keys.include? j
        end
        SparseVector.new c
    end

	def comprobar
		contar = 0
		contartotal = 0
		result = 0
   	for r in @matrix.keys do
	 		for j in @matrix[r].vector.keys do
				contartotal = contartotal + 1
				if @matrix[r].vector[j] == 0 
					contar = contar + 1
				end
			end
      end
		result = (contar * 100) / contartotal
		if result < 60 
			 "La matriz no es dispersa"
		end
	end

	def mostrar
        for r in @matrix.keys do
		  		for j in @matrix[r].vector.keys do
					print "#{@matrix[r].vector[j]}  "  
				end
				puts
        end
	end
	
	def +(other)
		
		  result = 0
		  suma = SparseMatrix.new 1 => {1 => 0, 2 => 0}, 2 => {1 => 0, 2 => 0}
        for r in @matrix.keys do
		  		for j in @matrix[r].vector.keys do	
					print "#{@matrix[r].vector[j] + other.matrix[r].vector[j]}  "
				end
				puts
        end
	end
	def -(other)
        for r in @matrix.keys do
		  		for j in @matrix[r].vector.keys do
					print "#{@matrix[r].vector[j] - other.matrix[r].vector[j]}  "
				end
				puts
        end
	end

	def *(other) 
	
		#c = @matrix[1].vector.keys #Hay que inicializarlo asi, creo. De otro modo falla.
		sumatotal = 0
		l = 0
		mul = Array.new		

		for i in @matrix.keys do
			mul[i] = Array.new
     		for j in @matrix[i].vector.keys do
				for k in @matrix[i].vector.keys do
		      	suma = @matrix[i].vector[k] * other.matrix[k].vector[j]
					sumatotal = sumatotal + suma;
				end
				#c[l] = sumatotal
				mul[i][j] = sumatotal
				l = l + 1
				sumatotal = 0
	    	end
		end	
		for r in @matrix.keys do
		  		for j in @matrix[r].vector.keys do
					print "#{mul[r][j]}  "
				end
				puts
        end
	end

	def max
		   
		maximo = @matrix[1].vector[1]
   	
		for i in @matrix.keys do
			for j in @matrix[i].vector.keys do
			   if @matrix[i].vector[j] > maximo
			      maximo = @matrix[i].vector[j]
		      end
		   end
		end
		 puts "El valor maximo es: #{maximo}"
	end

	def min

	   minimo = @matrix[1].vector[1]
		
		for i in @matrix.keys do
			for j in @matrix[i].vector.keys do
			   if @matrix[i].vector[j] < minimo
			      minimo = @matrix[i].vector[j]
		      end
		   end
		end
      puts "El valor minimo es: #{minimo}"

	end

	def coerce(other)
		puts [other,self]
	end
end

class Matriz_Dispersa < SparseMatrix

end

