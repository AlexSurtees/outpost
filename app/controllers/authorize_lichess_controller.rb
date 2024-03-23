require_relative '../services/lichess_client.rb'

class AuthorizeLichessController < ApplicationController
    def index
        session[:code_verifier] = LichessClient.create_code_verifier
        code_challenge = LichessClient.code_challenge(session[:code_verifier])
        uri = LichessClient.send_authorization_request(code_challenge)
        redirect_to(uri, allow_other_host: true)
    end

    def token
        res = LichessClient.get_access_token(session[:code_verifier], request.params['code'])
        params = JSON.parse(res.body)
        token = params['access_token']
        lichess_username = LichessClient.get_profile(token)['username']

        LichessAccount.create(
            user: current_user,
            token: token,
            username: lichess_username
        )
        redirect_to('/dashboard')
    end
end
