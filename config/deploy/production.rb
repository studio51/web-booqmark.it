set :branch, 'develop'

server '54.194.91.228',
  user: 'ubuntu',
  roles: %w{web app},
  ssh_options: {
    user: 'ubuntu',
    forward_agent: true,
    auth_methods: %w(publickey password),
    password: 'please use keys'
  }
