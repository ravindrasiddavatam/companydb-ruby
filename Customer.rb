require_relative "Person.rb"
require_relative "Purchase.rb"

class Customer < Person

    attr_accessor :_history

    def initialize(_name,_email,_phone)
        super(_name,_email,_phone)
        @_history = Array.new
    end

    def add_purchase(purchase)
        @_history.push(purchase)
    end

    def purchase_begin
        return 0
    end
    
    def purchase_end
        return @_history.length
    end
   
    def print
        puts (name+"  <"+email+">  Phone: "+phone)
        puts "Order History"
        puts "Item               Price            Quantity                Total"
        for termp in @_history
            puts termp.item+"           "+termp.cost.to_s+"          "+termp.qty.to_s+"           "+termp.total.to_s
        end
    end
end