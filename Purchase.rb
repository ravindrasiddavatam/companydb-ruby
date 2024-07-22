class Purchase
    attr_accessor :_item,:_qty,:_cost

    def initialize(_item,_qty,_cost)
        @_item = _item
        @_qty  = _qty
        @_cost = _cost
    end

    def item
        return @_item
    end

    def qty
        return @_qty
    end

    def cost
        return @_cost
    end
    
    def total
        result = @_cost * @_qty
        return result
    end
end