class RegistrationsController < Devise::RegistrationsController
  def create
    super

    name = marvel.split(' ')

    profile = Profile.new

    profile.user_id    = self.resource.id
    profile.first_name = name[0]
    profile.last_name  = name[1]

    if resource.save
      profile.save
    end
  end

  private

  def marvel
    [
      'Peter Parker',
      'Bruce Wayne',
      'Clark Kent',
      'Oliver Queen',
      'Matt Murdock',
      'Jean Grey',
      'Tony Stark'
    ].sample
  end
end
