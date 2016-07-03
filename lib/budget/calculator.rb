module Budget
	class Calculator

		def initialize
			@service = GoogleApi.new
		end

		def grab_expenses( paychecks_to_grab = 1 )
			calendar_id = ''
			response = @service.list_events(calendar_id,
	                               max_results: 10,
	                               single_events: true,
	                               order_by: 'startTime',
	                               time_min: paycheck_date(:current).iso8601).items
			response.map {|x| Expense.new(x) }
		end

		def paycheck_date( n_or_p, scale: 1, current: Date.today )
			pay_day = Date.new(2016, 6, 24)
			case n_or_p
			when :current
				while pay_day < current && current - pay_day > 14
					pay_day += 14
				end
			when :next
				while pay_day < current
					pay_day += 14
				end
			end
			return pay_day.to_time
		end

		def list_expenses( expenses )
			tp expenses
		end

		def current_expenses
			current = paycheck_date( :current ).to_date
			nxt = paycheck_date( :next, scale: 1 ).to_date
			expenses_for_range( current, nxt)
		end

		def expenses_for_range(current, nxt)
			grab_expenses(4).select { |x| x.date >= current && x.date < nxt }
		end

		def show_budget
			puts "Current pay day: #{paycheck_date(:current).strftime("%B %e %Y")}"
			puts "Amount due: #{current_expenses.inject(0) {|total,expense| total + expense.amount}}"
			list_expenses(current_expenses)
		end

	end

end