namespace :data do
  namespace :load do
    namespace :default do
      # :all does not include users as that task may not be safe for all environments
      desc "Load all default data"
      task :all => %w(users).map{ |task| "data:load:default:#{task}" } + %w()
      
      desc "Load default users"
      task :users => :environment do
        users = [
                  # first_name last_name    email
                  ['Andrew', 'Carpenter',  'acarpen@wested.org'],
                  ['Mark',   'Nutini',     'mnutini@wested.org'],
                  ['James',  'Wachira',    'jwachir@wested.org'],
                  ['Bob',    'Burbach',    'bburbac@wested.org'],
                  ['Joel',   'Henderson',  'jhender@wested.org'],
                  ['Tim',    'Harrison',   'jhender@wested.org'],
                  ['Brian',  'Case',       'bcase@wested.org'  ],
                  ['Dave',   'Augustine',  'daugust@wested.org'],
                ]

        users.each do |user|
          u = User.find_by_email(user[2]) || User.new
          u.first_name = user[0]
          u.last_name = user[1]
          u.email = user[2]
          u.role = 'Admin'
          u.save(false)
        end
      end
      
    end #namespace :default
  end #namespace :load
end #namspace :data
