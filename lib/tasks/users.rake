namespace :users do
  desc "TAREA PARA CREAR O ACTUALIZAR USUARIO"
  task manipulate: :environment do |task, args|
    email = ENV['email']
    if email.present?
      user = User.find_or_create_by(email: email.strip)
      if user.new_record?
        pass = validate_password(ENV['password'])
        user.password = pass
        user.password_confirmation = pass
        if user.save
          p 'created.'
        else
          p user.errors.messages
        end
      else
        pass = ENV['password']
        if pass.present?
          pass = validate_password(pass)
          user.password = pass
          user.password_confirmation = pass
        end

        enabled = ENV['enabled']
        if enabled.present? && (enabled == 'true' || enabled == 'false')
          user.enabled = enabled == 'true'
        end

        if user.save
          p 'user updated.'
        else
          p user.errors.messages
        end
      end
    end
  end

  def validate_password(pass)
    if pass.nil?
      abort 'password cant be blank'
    end
    pass = pass.strip
    if pass.length < 6
      abort 'minimal password need 6 characters.'
    end
    pass
  end

end