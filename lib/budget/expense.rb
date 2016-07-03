module Budget
		class Expense

		attr_accessor :name, :amount, :date

		def initialize( event )
			@date = Date.parse (event.start.date || event.start.date_time).to_s
			event.summary =~ /(.+) \$?(\d+)/
			@name = $1
			@amount = $2.to_i
		end

	end
end