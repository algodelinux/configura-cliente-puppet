package { puppet:
   ensure=>"installed"
}

file { "/etc/default/puppet":
   content => "# Defaults for puppet - sourced by /etc/init.d/puppet\n\n# Start puppet on boot?\nSTART=yes\n\n# Startup options\nDAEMON_OPTS=\"\"\n"
}

file { "/etc/puppet/puppet.conf":
   content => "[main]\nlogdir=/var/log/puppet\nvardir=/var/lib/puppet\nssldir=/var/lib/puppet/ssl\nrundir=/var/run/puppet\nfactpath=$vardir/lib/facter\n#pluginsync=true\nserver=puppetinstituto\nruninterval=5400\nsyslogfacility=\nreport=true\n\n[master]\ntemplatedir=/var/lib/puppet/templates\n\n[agent]\nreport = true",
   require => Package["puppet"],
}

file { "/etc/escuela2.0":
   content => "use=workstation",
}

file { "/usr/lib/ruby/1.8/facter/leefichero.rb":
   content => 'if File.exists?("/etc/escuela2.0")
   File.open("/etc/escuela2.0").each do |line|
      var = nil
      value = nil

      var = $1 and val = $2 if line =~ /^(.+)=(.+)$/


      if var != nil && val != nil
         Facter.add(var) do
            setcode { val }
         end
      end
   end
end',
}

file { "/var/lib/puppet/reports":
   ensure => directory
}

file { "/var/lib/puppet/ssl":
   ensure => absent,
   force => true,
}

service { puppet:
    ensure => running,
    require => Package["puppet"],
    subscribe => File["/etc/default/puppet","/etc/puppet/puppet.conf"]
}
