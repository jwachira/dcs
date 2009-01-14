namespace :db do
  desc 'load wested users: Rolf, Andrew, James, Mark, Date, Bob'
  task :load_wested_users => :environment do
    users = [
            # first_name last_name     email
             ['Rolf',   'Hanson',     'rhanson@wested.org'],
             ['Andrew', 'Carpenter',  'acarpen@wested.org'],
             ['Mark',   'Nutini',     'mnutini@wested.org'],
             ['James',   'Wachira',   'jwachir@wested.org'],
             ['Bob',   'Burbach',     'bburbac@wested.org'],
			 ['Dave',  'Augustine',   'daugust@wested.org'],
			 ['Joel',  'Henderson',   'jhender@wested.org'],
			 ['Brian',  'Case',       'bcase@wested.org']
            ]
    
    users.each do |user|
      u = User.find_by_email(user[2]) || User.new
      u.first_name = user[0]
      u.last_name = user[1]
      u.email = user[2]
      u.save(false)
    end
  end
end
