# -*- mode: ruby -*-
# vi: set ft=ruby :

APP_NAME = 'booqmarkit'

Vagrant.configure(2) do |config|

  ## Ubunutu 14.04 LTS

  config.vm.box = 'trusty64'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  boxes = [
    {
      name: 'app',
      ip: '10.0.1.51', host: 1337,
      cpu: 2, ram: '2048', cap: '80',
      nfs: true
    }
    #,
    # {
    #   name: 'mysql',
    #   ip: '10.0.51.2', host: 2337,
    #   cpu: 1, ram: '1048', cap: '50',
    #   nfs: true
    # },
    # {
    #   name: 'elasticsearch',
    #   ip: '10.0.51.3', host: 3337,
    #   cpu: 1, ram: '512', cap: '50',
    #   nfs: true
    # },
    # {
    #   name: 'redis',
    #   ip: '10.0.51.4', host: 4337,
    #   cpu: 1, ram: '256', cap: '50',
    #   nfs: true
    # },
    # {
    #   name: 'rabbitmq',
    #   ip: '10.0.51.5', host: 5337,
    #   cpu: 1, ram: '256', cap: '50',
    #   nfs: true
    # }
  ]

  boxes.each do |box|

    config.vm.define box[:name] do |box_config|

      box_config.vm.box       = APP_NAME + '.' + box[:name]
      box_config.vm.host_name = "#{APP_NAME}.app.dev"

      ## Network

      box_config.vm.network :forwarded_port, guest: 80, host: box[:host], auto_correct: true
      box_config.vm.network :private_network, ip: box[:ip]

      box_config.vm.provider :virtualbox do |vb|

        ## Default VirtualBox Settings

        vb.name = APP_NAME + '.' + box[:name]
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

      box_config.vm.synced_folder './', '/vagrant', type: 'nfs' if box[:nfs]
    end
  end

  config.ssh.forward_agent = true
end
