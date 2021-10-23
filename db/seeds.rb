# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create!(email: 'captain@flint.com', password: '123456', role: 'hirer')
user_profile = UserProfile.create!(name: 'James MacGraw', social_name: 'Flint', birth_date: '01/02/1700', picture: 'https://cdna.artstation.com/p/assets/images/images/003/183/004/medium/kseniia-tselousova-543-flint-s.jpg?1470745013', user: user)

another_user = User.create!(email: 'edward@teach.com', password: '123456', role: 'hirer')
another_user_profile = UserProfile.create!(name: 'Edward Teach', social_name: 'Blackbeard', birth_date: '02/03/1700', picture: 'https://graveyardoftheatlantic.com/wp-content/uploads/2016/11/blackbeard.jpg', user: another_user)

professional = User.create!(email: 'anne@bonny.com', password: '123456', role: 'hireable')
professional_profile = UserProfile.create!(name: 'Anne Bonny', social_name: 'Adam Bonny', birth_date: '03/04/1700', major: 'Thief', bio: 'You don\'t want to know', experience: 'Member of Calico\'s crew', picture: 'https://64.media.tumblr.com/349863f4fa0d1523364bfc5fe5bce824/tumblr_pkj9ry9qKM1qeu6ilo1_500.jpg', user: professional)

another_professional =  User.create!(email: 'jack@rackam.com', password: '123456', role: 'hireable')
another_professional_profile = UserProfile.create!(name: 'Jack Rackham', social_name: 'Calico Jack', birth_date: '04/05/1700', major: 'Fighting & Plundering', bio: 'The inventor of the Jolly Rogers', experience: 'Several years on the crew under captain Charles Vane', picture: 'https://assassinscreedcenter.files.wordpress.com/2013/10/piratas-calico-jack-rackham.jpg', user: another_professional)


project = Project.create!(title:'Salvar Nassau', description:'Busco pessoas interessadas em recuperar Nassau do domínio de Woodes Rogers', wanted_skills:'Ser capaz de lutar', max_pay: 50, expiration_date:10.days.from_now, user: user)
Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: professional)
Proposal.create!(presentation:'I sure can fight', charges: 80, week_hours: 50, total_hours: 300, project: project, user: another_professional)


project = Project.create!(title:'Encontrar e saquear o Urca De Lima', description:'Em busca de uma tripulação capaz de roubar o ouro dos espanhóis', wanted_skills:'Saber ler carta náutica', max_pay: 50, expiration_date:5.days.from_now, user: user)
Proposal.create!(presentation:'O melhor quartermaster e helmsman desse lado das Bahamas', charges: 50, week_hours: 50, total_hours: 200, project: project, user: professional)
Proposal.create!(presentation:'I sure can fight', charges: 80, week_hours: 50, total_hours: 300, project: project, user: another_professional)
