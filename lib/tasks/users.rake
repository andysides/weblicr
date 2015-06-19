namespace :users do
  desc "TODO"
  task add_authtoken_to_users: :environment do
    @users = User.connection.select_all("SELECT * FROM users")

    @users.each do |u|
      tmp = User.find(u["id"])
      tmp.generate_token("auth_token")
      tmp.save
    end
  end

end
