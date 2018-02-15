def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit enter twice."
  students = []
  name = gets.chomp
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

students = input_students
print_header
print(students)
print_footer(students)
