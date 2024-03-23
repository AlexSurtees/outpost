require 'base64'
require 'digest'
require 'securerandom'
require 'uri'
require 'net/http'
require 'httparty'

class LichessClient
    def self.create_code_verifier
        return SecureRandom.hex(32)
    end

    def self.code_challenge(code_verifier)
        Base64.urlsafe_encode64(
          OpenSSL::Digest::SHA256.digest(code_verifier)
        ).gsub(/=/, '')
    end

    def self.send_authorization_request(code_challenge)
        uri = URI('https://lichess.org/oauth')
        params = {
            :response_type => "code",
            :client_id => 'localhost',
            :redirect_uri => 'http://localhost:3000/authorize/token',
            :code_challenge_method => 'S256',
            :code_challenge => code_challenge,
            :scope => 'puzzle:read'
        }
        uri.query = URI.encode_www_form(params)
        return uri
    end

    def self.get_access_token(code_verifier, authorization_code)
        uri = URI('https://lichess.org/api/token')
        params = {
            :grant_type => "authorization_code",
            :code => authorization_code,
            :code_verifier => code_verifier,
            :redirect_uri => 'http://localhost:3000/authorize/token',
            :client_id => 'localhost'
        }
        return Net::HTTP.post_form(uri, params)
    end

    def self.get_profile(token)
        headers = {
            "Authorization" => "Bearer " + token
        }
        response = HTTParty.get(
            'https://lichess.org/api/account',
            :headers => headers
        )
        return JSON.parse(response.body)
    end

    def self.get_games(user, since)
        response = HTTParty.get(
            'https://lichess.org/api/games/user/' + user,
            :query => {
                'since' => since,
                'pgnInJson' => true
            },
            :headers => {
                'Accept' => 'application/x-ndjson'
            }
        )
        games = response.split("\n")
        games_json = []
        games.each do |game|
            games_json.append(JSON.parse(game))
        end
        return games_json
    end

    def self.get_reviews(user, since)
        response = HTTParty.get(
            'https://lichess.org/api/study/by/' + user,
            :headers => {
                'Accept' => 'application/x-ndjson'
            }
        )
        reviews = response.split("\n")
        reviews_json = []
        reviews.each do |review|
            review_json = JSON.parse(review)
            if review_json['createdAt'] > since
                reviews_json.append(review_json)
            end
        end
        return reviews_json
    end

    def self.get_puzzles(token, since)
        response = HTTParty.get(
            'https://lichess.org/api/puzzle/activity',
            :query => {
                'max' => 25
            },
            :headers => {
                'Accept' => 'application/x-ndjson',
                "Authorization" => "Bearer " + token
            }
        )
        puzzles = response.split("\n")
        puzzles_json = []
        puzzles.each do |puzzle|
            puzzle_json = JSON.parse(puzzle)
            if puzzle_json['date'] > since
                puzzles_json.append(puzzles_json)
            end
        end
        return puzzles_json
    end
end