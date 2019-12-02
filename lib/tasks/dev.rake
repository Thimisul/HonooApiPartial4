namespace :dev do
  desc "TODO"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate)} 
      %x(rails dev:populate)
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end

  end

  desc "TODO"
  task populate: :environment do

    
    show_spinner("Cadastrando Tipos de Eventos...") do
      eventType = [{name: "Caminhada"},{name: "Corrida"},{name: "Bicicleta"},{name: "Futebol"}]
      eventType.each do |eventType|
        EventType.find_or_create_by!(eventType)
      end
    end

    show_spinner("Cadastrando usuarios...") do
      
      100.times do |i|
        user = Faker::Internet.username
        if (rand(0..1) == 1)
          @aux = "M"
        else
          @aux = "F"
        end
        User.find_or_create_by!(
          username: user,
          email: Faker::Internet.email(name: user),
          password: Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true, special_characters: true),
          birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
          sex: @aux
        )
      end
    end


    show_spinner("Cadastrando Eventos...") do
      200.times do |i|
        startDate = Faker::Time.between(from: 1.year.ago, to: 1.year.from_now)
        Event.find_or_create_by!(
          title: Faker::Lorem.sentence,
          startDate: startDate,
          endDate: startDate + 2.hours,
          street: Faker::Address.street_address,
          neighborhood: Faker::Address.city_suffix,
          city: Faker::Address.city,
          referencePoint: Faker::Address.city_prefix,
          description: Faker::Lorem.paragraph(sentence_count: 2),
          eventTypeId: rand(1..4),
          ownerId: rand(1..100),
          status: true
        )
      end
    end

    show_spinner("Cadastrando Participantes...") do
      
      200.times do |i|
        event_id = rand(1..100)
        eventdate = Event.find(event_id).startDate

        Participant.find_or_create_by!(
          eventoId: event_id,
          userId: rand(1..100),
          registrationDate: Faker::Time.between(from: eventdate - rand(1..24).hours, to: eventdate)
          )
      end
    end

    show_spinner("Cadastrando Messages...") do
      600.times do |i|
        @participant_id = rand(1..200)
        Msg.find_or_create_by!(
          participantId: @participant_id,
          date: ((Participant.find(@participant_id).registrationDate) + (1.hour) or + (2.hour)),
          message: Faker::Lorem.paragraphs
          )
      end
    end

  end


  private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end
end
