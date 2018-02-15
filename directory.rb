def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit enter twice."
  name = gets.chomp
  students = []
  until name == ""
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students."
    name = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(student_arr)
  student_arr.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(student_arr)
  puts "Overall we have #{student_arr.count} great students"
end

def interactive_menu
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    selection = gets.chomp
    case selection
    when "1"
      students = input_students
    when "2"
      print_header
      print(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "Sorry, I didn't understand that instruction, please try again."
    end
  end
end

interactive_menu
