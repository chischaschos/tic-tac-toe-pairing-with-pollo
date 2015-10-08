# This to become our GameApi application
class GameApi
  def call(_env)
    [200, {}, 'guadap']
  end
end
