module Budget

	class Payday

		class << self
			def current
				pay_day = Date.new( 2016, 6, 24 )
				while pay_day < Date.today && Date.today - pay_day > 14
					pay_day + 14
				end
				Payday.new( pay_day )
			end
			def next
				current.next
			end
		end

		def initialize(date)
			@date = date
		end

		def next
			@date + 14
		end

		def to_s
			@date.strftime("%B %e %Y")
		end

		def to_time
			@date.to_time
		end

		def to_date
			@date
		end

		def end_date
			@date + 13
		end

	end

end