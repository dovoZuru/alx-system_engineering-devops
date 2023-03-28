#installing nginx using puppet

class nginx {
  package { 'nginx':
    ensure => 'installed',
  }
  
  service { 'nginx':
    ensure => 'running',
    enable => true,
  }
  
  file { '/etc/nginx/sites-available/default':
    content => "server {
                  listen 80;
                  root /var/www/html;
                  
                  location / {
                    return 301 /hello;
                  }
                  
                  location /hello {
                    return 200 'Hello World!';
                  }
                }",
    notify => Service['nginx'],
  }
  
  file { '/var/www/html/index.html':
    ensure  => 'file',
    content => '',
  }
}

include nginx
