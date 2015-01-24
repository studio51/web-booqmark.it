# -*- mode: ruby -*-
# vi: set ft=ruby :

APP_NAME = 'booqmarkit'

Vagrant.configure(2) do |config|

  ## Ubunutu 14.04 LTS

  config.vm.box = 'trusty64'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  boxes = [
    {
      :name => 'web',
      :ip => '10.0.51.1', :host => 1337,
      :cpu => 2, :ram => '1048', :cap => '80',
      :nfs => true
    }
  ]

  boxes.each do |box|

    config.vm.define box[:name] do |box_config|

      box_config.vm.box       = APP_NAME + '-' + box[:name]
      box_config.vm.host_name = APP_NAME

      ## Network

      box_config.vm.network :forwarded_port, guest: 80, host: box[:host], auto_correct: true
      box_config.vm.network :private_network, ip: box[:ip]

      box_config.vm.provider :virtualbox do |vb|

        ## Default VirtualBox Settings

        vb.name = APP_NAME + ' ' + box[:name].upcase
        vb.gui  = false

        ## Resources Settings

        vb.customize ['modifyvm', :id,
          '--ioapic', 'on',
          '--cpus', box[:cpu],
          '--cpuexecutioncap', box[:cap],
          '--memory', box[:ram],
        ]
      end

      # NFS | Need for Speed

      if box[:nfs] == true

        box_config.vm.synced_folder './', '/vagrant', type: 'nfs'
      end
    end
  end

  config.ssh.forward_agent = true
end
