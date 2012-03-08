namespace :apache do
  task :configure do
    make_shared_config_dir
    result = parse_template(template('config/virtual_host.conf'))
    put result, "#{shared_path}/config/#{application}-#{rails_env}-#{branch}.conf", :mode => 0644

    # sudo "rm -f /etc/apache2/sites-enabled/#{application}-#{rails_env}-#{branch}.conf && ln -s #{shared_path}/config/#{application}-#{rails-env}-#{branch}.conf /etc/apache2/sites-enabled/#{application}-#{rails-env}-#{branch}.conf"
  end
end
