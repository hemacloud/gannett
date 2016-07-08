actions :install
property :source, String
property :version, String, name_property: true
action :install do
  remote_file "#{Chef::Config[:file_cache_path]}/haproxy-#{node[:package_version]}.tar.gz" do
    #  source node['package']['url']
    mode '0644'
    action :create
    notifies :run, 'execute[unzip_archive]', :immediately
  end
  execute 'unzip_archive' do
    command 'tar xzf "#{Chef::Config[:file_cache_path]}/haproxy-#{node[:package_version]}.tar.gz"'
    cwd Chef::Config['file_cache_path'].to_s
    action :nothing
    notifies :run, 'execute[install_haproxy]', :immediately
  end
  execute 'install_haproxy' do
    command 'make TARGET=linux2628 && make install'
    cwd "#{Chef::Config[:file_cache_path]}/haproxy-#{node[:package_version]}"
    action :nothing
    notifies :run, 'bash[configure]', :immediately
  end
  bash 'configure' do
    user 'root'
    cwd Chef::Config[:file_cache_path]
    # tar xzf "#{Chef::Config[:file_cache_path]}/haproxy-#{node[:package_version]}.tar.gz"
    # cd "#{Chef::Config[:file_cache_path]}/haproxy-#{node[:package_version]}"
    # make TARGET=linux2628
    # make install
    code <<-EOH
    cp /usr/local/sbin/haproxy /usr/sbin/
    cp "#{Chef::Config[:file_cache_path]}/haproxy-#{node[:package_version]}/examples/haproxy.init" /etc/init.d/haproxy
    chmod 755 /etc/init.d/haproxy
    mkdir -p /etc/haproxy
    mkdir -p /run/haproxy
    mkdir -p /var/lib/haproxy
    touch /var/lib/haproxy/stats
 EOH
    action :nothing
  end
end
