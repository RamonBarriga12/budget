require 'thor'
module Budget
	class Cli < Thor

		desc "calculate", "shows this paychecks budget"
	  def calculate
	    calc = Budget::Calculator.new
	    puts "Budget for payday: #{Payday.current} - #{Payday.current.end_date}"
	    puts "Amount: #{calc.current_amount }"
	    tp calc.current_expenses
	  end

	end
end