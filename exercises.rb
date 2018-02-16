@students = []
@line_width = 80

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit enter twice when prompted for a name."
  puts "Whats is the student's name?"
  name = STDIN.gets.chomp
  until name == ""
    cohort = input_cohort
    country = input_country
    @students << {name: name, cohort: cohort, country: country}
    if @students.count == 1
      puts "Now we have 1 great student"
    else
      puts "Now we have #{@students.count} students."
    end
    puts "---------"
    puts "Whats is the students name?"
    name = STDIN.gets.chomp
  end
  @students
end

def input_country
  puts "In which country were they born?"
  country = STDIN.gets.chomp
end

def input_cohort
  puts "Which cohort are they joining?"
  answer = STDIN.gets.chomp
  if answer.length == 0
    cohort = cohort_to_sym
  else
    cohort = cohort_to_sym(answer.downcase)
  end
end

def cohort_to_sym(cohort="november")
  cohort.to_sym
end

def print_header
  puts "The students of Villains Academy".center(@line_width)
  puts "-------------".center(@line_width)
end

def print_student_list
  index = 0
  while index < @students.size
    puts("#{index + 1}. #{@students[index][:name]}, from: #{@students[index][:country]} (#{@students[index][:cohort]} cohort)".center(@line_width))
    index += 1
  end
end

def print_students_beginning_with_letter
  puts "Enter a letter"
  letter = STDIN.gets.chomp
  puts "Here are the students whose name begins with #{letter.upcase}"
  puts "---------"
  @students.each_with_index do |student, index|
    if student[:name][0] == letter.upcase
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_students_name_fewer_than_12_characters
  puts "Here are the students with 12 or fewer characters in their name"
  puts "---------"
  @students.each_with_index do |student, index|
    if student[:name].split.join("").length <= 12
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer
  if @students.count == 1
    puts "Overall we have 1 great student".center(@line_width)
  else
    puts "Overall we have #{@students.count} great students".center(@line_width)
  end
end

def print_students_in_given_cohort
  puts "Which cohort would you liker to view"
  cohort = STDIN.gets.chomp
  puts students_by_cohort(cohort)
end

def students_by_cohort(str)
  puts "#{str.capitalize} cohort".center(@line_width)
  puts "---------".center(@line_width)
  return_list = []
  @students.each do |student|
    if student[:cohort] == str.downcase.to_sym
      return_list << "#{student[:name]}, from: #{student[:country]}"
    end
  end
  return_list
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to exercises_students.csv"
  puts "4. Load list from exercises_students.csv"
  puts "5. Show students whose names begin with letter of your choice"
  puts "6. Show students whose name is 12 characters or less in length"
  puts "7. Show students in a particular cohort"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "5"
      print_students_beginning_with_letter
    when "6"
      print_students_name_fewer_than_12_characters
    when "7"
      print_students_in_given_cohort
    when "9"
      exit
    else
      puts "Sorry, I didn't understand that instruction, please try again."
  end
end

def save_students
  file = File.open("exercises_students.csv", "w")
    @students.each do |student|
    student_data = [student[:name], student[:country], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "exercises_students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, country, cohort = line.chomp.split(",")
    @students << {name: name, country: country, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} does not exist"
    exit
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
