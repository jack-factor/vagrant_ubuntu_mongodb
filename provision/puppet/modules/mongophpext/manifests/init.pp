class mongophpext {

    package { "build-essential": 
        ensure => "installed",
    }

    exec { "pecl mongo":
        command => "pecl install mongo-1.5.4",
        require => [Package["build-essential"], Package["php-pear"], Package["php5"],Package["php5-dev"], Package["php5-cli"]],
        unless =>  "pecl list | grep 'mongo'"
              
        #logoutput => "on_failure",
    }

    file { "/etc/php5/conf.d/mongo.ini":
        content=> 'extension=mongo.so',
        require => [Exec["pecl mongo"]],
    }
}
