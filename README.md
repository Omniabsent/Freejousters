# FREEJOUSTERS

<b> Because finding your next freelancing project doesn't have to feel like a war </b>

Brought to you with the use of:

* Ruby 3.0.2p107, featuring the following gems:
  - capybara
  - rspec
  - devise

* Rails 6.1.4.1

* Manjaro 21.1.3

* Large amounts of black metal and gummy bears

<h3> Here's how to set up your very own Freejousters </h3>

 * Clone this repo using the following cli:
  git clone https://github.com/Omniabsent/Freejousters.git

* Navigate until inside the Freejousters folder

* Configure with:
  bin/setup

* Populate the db with a few examples using
  rails db:seeds

* Activate server with:
  rails server

* Open your prefered browser and visit localhost:3000

* Log in as any of the following:
  - If you want to be a captain with two active projects and a few proposals to them:
 email: 'captain@flint.com', password: '123456'
  - If you want to be a captain with a blank slate who comes up with a plan on the spot:
 email: 'edward@teach.com', password: '123456'
  - If you want to be a crew member ready to fight:
 email: 'anne@bonny.com', password: '123456'
  - If you want to be another crew member who also happens to be ready to fight:
 email: 'jack@rackam.com', password: '123456'

 After loging in, you can browse the profile of whichever other user you come across in the system, as well as favourite them.
 As a loged in captain [hirer], you can also create new projects, close or finish existing ones, and accept or refuse proposals from aspiring crew members [professionals]. As a professional looking to join a crew, you can browse projects, their creators, the team already working on it, and send your own proposal to be included in the team [or cancel it if you change your mind soon enough].
