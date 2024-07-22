require_relative "Employee.rb"
require_relative "Customer.rb"

class Company
    public
    attr_accessor :_employees,:_customers,:_name
    
    def initialize(_name)
        @_name = _name
        @_employees = Array.new
        @_customers = Array.new
    end

    def name
        return @_name
    end

    def add_employee(_employee)
        @_employees.push(_employee)
    end

    def add_customer(_customer)
        @_customers.push(_customer)
    end

    def employee_begin
        return 0
    end

    def employee_end
        return @_employees.length
    end

    def customer_begin
        return 0
    end

    def customer_end
        return @_customers.length
    end
end