Dado('que no hay usuarios en el sistema') do
  user_repository = UserRepository.new
  user_repository.delete_all
end

Cuando('una persona se registra con el usuario {string} y mail {string}') do |username, email|
  request_body = { platform_id: 141_733_544, username:, email: }.to_json
  @response = Faraday.post('/users', request_body, { 'Content-Type' => 'application/json' })
end

Entonces('la registracion es exitosa') do
  @response_body = JSON.parse(@response.body)
  expect(@response_body['status']).to eq(201)
end
