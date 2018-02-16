@students = []

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit enter twice."
  name = STDIN.gets.chomp
  until name == ""
    add_students_to_array(name)
    puts "Now we have #{@students.count} students."
    name = STDIN.gets.chomp
  end
  @students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall we have #{@students.count} great students"
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file of your choice"
  puts "4. Load list from file of your choice"
  puts "5. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def choice_feedback(selection)
  if (1..5).include?(selection.to_i)
    puts "You chose option #{selection}"
    puts "---------"
  end
end

def process(selection)
  choice_feedback(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_specific_file
    when "5"
      exit
    else
      puts "Sorry, I didn't understand that instruction, please try again."
  end
end

def load_specific_file
  puts "Which file would you like to load?"
  filename = STDIN.gets.chomp
  if filename.empty? || !File.exists?(filename)
    puts "Invalid input. You will be returned to menu"
  else
    load_file(filename)
  end
end

def save_students
  puts "Which file would you like to save to?"
  filename = STDIN.gets.chomp
  file = File.open(filename, "w")
    @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def add_students_to_array(name, cohort="november")
  @students << {name: name, cohort: cohort.to_sym}
end

def load_file(filename)
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_students_to_array(name, cohort)
  end
  file.close
end

def load_students(filename="students.csv")
  load_file(filename)
end

# def try_load_students
#   filename = ARGV.first
#   return if filename.nil?
#   if File.exists?(filename)
#     load_students(filename)
#     puts "Loaded #{@students.count} from #{filename}"
#   else
#     puts "Sorry, #{filename} does not exist"
#     exit
#   end
# end

# alternative load method that loads students.csv by default
# if no valid filename is provided as a command line argument
def try_load_students
  filename = ARGV.first
  if filename.nil? || !File.exists?(filename)
    load_students("students.csv")
    puts "Loaded students.csv by default as no valid filename was provided"
  else
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  end
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

interactive_menu
