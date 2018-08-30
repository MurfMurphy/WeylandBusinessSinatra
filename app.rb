require 'sinatra'
require 'sendgrid-ruby'

get '/' do
    @title = 'Weyland Corporation'
    # @body_class = 'home' for time sake figure out later
    erb :home, layout: :layout
end

get '/our_mission' do
    @title = "Weyland's Mission"
    erb :our_mission, layout: :layout
end

get '/our_team' do
    @title = 'Our Team'
    erb :our_team, layout: :layout
end

get '/join_us' do
    @title = 'Join Us'
    erb :join_us, layout: :layout
    
end

post '/join_us' do
puts params.inspect

    from = SendGrid::Email.new(email:'alecmurphypersonal@gmail.com')
    subject = 'Test Hello World Please Ignore'     
    to = SendGrid::Email.new(email:'alecmurphypersonal@gmail.com')
    content = SendGrid::Content.new(type:'text/plain', value: params["text"])                   

    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    response = sg.client.mail._('send').post(request_body: mail.to_json)

    puts response.status_code
    puts response.body

    erb :home, layout: :layout

end

# post '/sign-in' do
#     @title = 'Sign-in'

#     puts params.inspect

#     params[:user]
#     params[:password]

#     "posted!"
# end