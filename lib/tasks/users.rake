config=YAML.load_file('config/accounts.yml')
admin = config['admin']

namespace :users do
  desc "Create and admin user from accounts.yml"
  task create_admin: :environment do
    u = User.create!(email: admin["email"], password: admin["password"], admin: true, is_active: true)
    if(u.save) then 
      puts("admin created")
    end 
  end

  desc "Update a users password"
  task update_pass: :environment do
  	puts "Enter the email address to update: "
  	email = STDIN.gets.chomp
    u = User.where("email = ?", email)

    if(u.length == 1) then
      u = u.first
      puts "Enter the new password for " + email + ": "
      p = STDIN.gets.chomp
      u.password = p
      u.password_confirmation = p
      if(u.save) then
        puts "password updated"
      end
    else
      puts "email not found"
    end
  end

  desc "Updgrade a user to admin"
  task make_admin: :environment do
    puts "Enter the email address to make admin: "
    email = STDIN.gets.chomp
    u = User.where("email = ?", email)

    if(u.length == 1) then
      u = u.first
      u.admin = true
      if(u.save) then
        puts "user account now admin"
      end
    else
      puts "email not found"
    end
  end
end