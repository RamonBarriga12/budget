require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'
require 'date'
require 'table_print'


require "budget/version"
require "budget/google_api"
require "budget/calculator"
require "budget/expense"
require "budget/payday"

module Budget
  def self.calculate
  	Budget::Calculator.new.show_budget
  end
end
