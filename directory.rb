# students in an array
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]
  # now print each student
puts "The students of Villains Academy"
puts "-------------"
students.each { |student| puts student }
# finally we print the total number of students
print "Overall we have #{students.count} great students"
