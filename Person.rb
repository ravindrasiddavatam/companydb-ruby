class Person
    def initialize(_name, _email, _phone)
      @_name = _name
      @_email = _email
      @_phone = _phone
    end

    def name
      return @_name
    end

    def name=(_name)
      @_name = _name
    end

    def email
      return @_email
    end

    def email=(_email)
      @_email = _email
    end

    def phone
      return @_phone
    end
    
    def phone=(_phone)
      @_phone = _phone
    end
  end