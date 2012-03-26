namespace :db do
  # desc "Run the mysql shell for the current environment using the configuration defined in database.yml"
  # task :shell, :roles => :db, :only => { :primary => true } do
  #   input = ''
  #   run "cd #{current_path} && rake #{rails_env} db:shell" do |channel, stream, data|
  #     next if data.chomp == input.chomp || data.chomp == ''
  #     print data
  #     channel.send_data(input = $stdin.gets) if data =~ /^(>|\?)>/
  #   end
  # end

  desc "Creates a database.yml file in shared/config. It will prompt for the database password."
  task :configure do
    setup_shared_folders
    file = 'config/database.yml'
    result = parse_template(template(file))
    put result, "#{shared_path}/#{file}", :mode => 0644
  end

  namespace :data do
    desc "Load seed fixtures (from db/fixtures) into the current environment's database."
    task :seed, :roles => :db, :only => { :primary => true } do
      run "cd #{current_path} && rake #{rails_env} db:data:seed"
    end
  end

  namespace :backup do
    desc "Creates a backup of the database."
    task :create, :roles => :db, :only => {:primary => true} do
      ENV['BACKUP_DIR'] ||= "#{shared_path}/backups"
      run "cd #{current_path} && rake #{rails_env} db:backup:create BACKUP_DIR=#{ENV['BACKUP_DIR']}"
    end

    desc "Restores a backup of the database."
    task :restore, :roles => :db, :only => {:primary => true} do
      ENV['BACKUP_DIR'] ||= "#{shared_path}/backups"
      run "cd #{current_path} && rake #{rails_env} db:backup:restore BACKUP_DIR=#{ENV['BACKUP_DIR']}"
    end
  end

  desc "Pull Database"
  task :pull, :roles => :db do
    require "yaml"
    get "#{shared_path}/config/database.yml", "/tmp/database.yml"
    db_settings = YAML.load_file("/tmp/database.yml")
    database = db_settings["#{rails_env}"]["database"]
    username = db_settings["#{rails_env}"]["username"]
    password = db_settings["#{rails_env}"]["password"]
    host = db_settings["#{rails_env}"]["host"]

    filename = "#{database}-#{Time.now.strftime '%Y%m%d%H%M%S'}.dump"

    on_rollback {
      run "rm /tmp/#{filename}"
      run "rm /tmp/#{filename}.gz"
      run "rm /tmp/database.yml"
    }

    run "mysqldump -u#{username} -h#{host} -p'#{password}' #{database} > /tmp/#{filename}"
    run "gzip /tmp/#{filename}"
    get "/tmp/#{filename}.gz", "/tmp/#{filename}.gz"
    run "rm /tmp/#{filename}.gz"

    local_db_settings = YAML.load_file("#{Dir.pwd}/config/database.yml")
    local_database = local_db_settings["development"]["database"]
    local_username = local_db_settings["development"]["username"]
    local_password = local_db_settings["development"]["password"]

    system "gunzip /tmp/#{filename}.gz"
    system "mysqladmin -f -u#{local_username} drop #{local_database}"
    system "mysqladmin -f -u#{local_username} create #{local_database}"
    system "mysql -u#{local_username} #{local_database} < /tmp/#{filename}"
    system "rm /tmp/#{filename}"
    system "rm /tmp/database.yml"
  end
end
