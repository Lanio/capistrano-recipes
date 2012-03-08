namespace :apache do
  desc "Creates an apache conf file in shared/config. You will need to modify the file and symlink it to /etc/apache2/site-available."
  task :configure do
    setup_shared_folders
    result = parse_template(template('config/virtual_host.conf'))
    put result, "#{shared_path}/config/#{application}-#{rails_env}-#{branch}.conf", :mode => 0644

    # sudo "rm -f /etc/apache2/sites-enabled/#{application}-#{rails_env}-#{branch}.conf && ln -s #{shared_path}/config/#{application}-#{rails-env}-#{branch}.conf /etc/apache2/sites-enabled/#{application}-#{rails-env}-#{branch}.conf"
  end
end
