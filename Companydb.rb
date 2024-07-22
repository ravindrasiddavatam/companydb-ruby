require_relative "Company.rb"

def main_menu
  puts "   MAIN MENU"
  puts "1.) Employees"
  puts "2.) Sales"
  puts "3.) Quit"
  print "Choice? "
end

def display_employees(company)
  company._employees.each(&:print)
end

def add_employee_menu(company)
  company.add_employee(handle_employee_input)
end

def handle_employee_input
  print "Name: "
  name = gets.chomp
  print "Email: "
  email = gets.chomp
  print "Phone: "
  phone = gets.chomp
  print "Salary: "
  salary = gets.chomp.to_f
  Employee.new(name, email, phone, salary)
end

def read_data(company)
  file_name = "#{company.name}.dat"
  File.open(file_name, 'r') do |file|
    read_employees(file, company)
    read_customers(file, company)
  end
  company
end

def read_employees(file, company)
  employee_count = file.readline.to_i
  employee_count.times do
    company.add_employee(Employee.new(
      file.readline.chomp,
      file.readline.chomp,
      file.readline.chomp,
      file.readline.to_f
    ))
  end
end

def read_customers(file, company)
  customer_count = file.readline.to_i
  customer_count.times do
    customer = Customer.new(file.readline.chomp, file.readline.chomp, file.readline.chomp)
    read_purchases(file, customer)
    company.add_customer(customer)
  end
end

def read_purchases(file, customer)
  purchase_count = file.readline.to_i
  purchase_count.times do
    purchase = Purchase.new(
      file.readline.chomp,
      file.readline.to_i,
      file.readline.to_f
    )
    customer.add_purchase(purchase)
  end
end

def write_data(company)
  file_name = "#{company.name}.dat"
  File.open(file_name, 'w') do |file|
    write_employees(file, company)
    write_customers(file, company)
  end
end

def write_employees(file, company)
  file.write("#{company.employee_end}\n")
  company._employees.each do |employee|
    file.write("#{employee.name}\n#{employee.email}\n#{employee.phone}\n#{employee.salary}\n")
  end
end

def write_customers(file, company)
  file.write("#{company.customer_end}\n")
  company._customers.each do |customer|
    file.write("#{customer.name}\n#{customer.email}\n#{customer.phone}\n")
    file.write("#{customer.purchase_end}\n")
    customer._history.each do |purchase|
      file.write("#{purchase.item}\n#{purchase.qty}\n#{purchase.cost}\n")
    end
  end
end

def sales_menus
  print "(A)dd Customer, Enter a (S)ale, (V)iew Customer, or (M)ain Menu? "
end

def add_customer(company)
  company.add_customer(handle_customer_input)
end

def handle_customer_input
  print "Name: "
  name = gets.chomp
  print "Email: "
  email = gets.chomp
  print "Phone: "
  phone = gets.chomp
  Customer.new(name, email, phone)
end

def enter_sale(company)
  if company.customer_end < 1
    puts "Error: No Customers."
  else
    display_customer_choices(company)
    index = gets.chomp.to_i - 1
    add_purchase(company, index) if valid_customer_index?(index, company)
  end
end

def display_customer_choices(company)
  company._customers.each_with_index { |customer, i| puts "#{i + 1}.)#{customer.name}" }
  print "Choice? "
end

def valid_customer_index?(index, company)
  index >= 0 && index < company._customers.size
end

def add_purchase(company, customer_index)
  company._customers[customer_index].add_purchase(handle_purchase_input)
end

def handle_purchase_input
  print "Item: "
  item = gets.chomp
  print "Quantity: "
  quantity = gets.chomp.to_i
  print "Cost: "
  cost = gets.chomp.to_f
  Purchase.new(item, quantity, cost)
end

def view_customer(company)
  if company.customer_end < 1
    puts "Error: No Customers."
  else
    display_customer_choices(company)
    index = gets.chomp.to_i - 1
    company._customers[index].print if valid_customer_index?(index, company)
  end
end

def start
  print "Company Name: "
  company_name = gets.chomp
  company = create_or_load_company(company_name)
  main_menu_loop(company)
end

def create_or_load_company(company_name)
  begin
    company = Company.new(company_name)
    read_data(company)
  rescue
    company = Company.new(company_name)
  end
end

def main_menu_loop(company)
  loop do
    main_menu
    choice = gets.chomp.to_i
    case choice
    when 1
      employee_menu(company)
    when 2
      sales_menu(company)
    when 3
      write_data(company)
      break
    end
  end
end

def employee_menu(company)
  loop do
    display_employees(company)
    print "(A)dd Employee or (M)ain Menu? "
    picker = gets.chomp
    case picker
    when "A"
      add_employee_menu(company)
    when "M"
      break
    end
  end
end

def sales_menu(company)
  loop do
    sales_menus
    picker = gets.chomp
    case picker
    when "A"
      add_customer(company)
    when "S"
      enter_sale(company)
    when "V"
      view_customer(company)
    when "M"
      break
    end
  end
end

start
