require 'random_data'

#Create Users
5.times do
	User.create!(
   		email: RandomData.random_email,
   		password: RandomData.random_sentence
	)
end
users = User.all

#Create Wikis
50.times do 
	Wiki.create!(
		user: users.sample,
		title: RandomData.random_sentence,
		body: RandomData.random_paragraph,
		private: false 
	)
end
wiki = Wiki.all

#Create Collaborators
10.times do 
	Collaborator.create!(
		user: users.sample,
   		wiki: wiki.sample,
	)
end
collaborator = Collaborator.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{Collaborator.count} collaborators created"