module Rulers
  class Application
    def get_controller_and_action(env)
      # raise Exception, env.inspect
      # puts "Rack environment: #{env.inspect}"
      _, cont, action, after = env["PATH_INFO"].split('/', 4)
      cont = cont.capitalize # "People"
      cont += "Controller" # "PeopleController"

      [Object.const_get(cont), action]
    end
  end
end
