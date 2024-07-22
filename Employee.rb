require_relative "Person.rb"

class Employee < Person
    attr_accessor :_salary
    def initialize(_name,_email,_phone,_salary)
        super(_name,_email,_phone)
        @_salary = _salary 
    end

    def salary=(_salary)
        @_salary = _salary
    end

    def salary
        return @_salary
    end

    def print
        puts (name+" <"+email+"> Phone: "+phone+" Salary: $"+salary.to_s)
    end
end