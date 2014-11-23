class Tag < ActiveRecord::Base

  def to_param
    [id, name].join(' ').parameterize
  end
end
