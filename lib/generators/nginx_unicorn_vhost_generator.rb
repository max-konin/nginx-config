class NginxUnicornVhostGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  argument :domain, :type => :string, :required => true, :desc => "site's domain"
  def create_instance
    template 'config.vhost.erb', "config/#{name}.vhost"
  end
end
