require_relative '../services/lichess_client.rb'

class DashboardController < ApplicationController
    def index
        if current_user
            if current_user.LichessAccount
                period_start = Date.today.beginning_of_week.strftime("%Q").to_i
                @date = Date.today.strftime("%e %B, %Y")
                game_response = LichessClient.get_games(current_user.LichessAccount.username, period_start)
                reviews = LichessClient.get_reviews(current_user.LichessAccount.username, period_start)
                puzzles = LichessClient.get_puzzles(current_user.LichessAccount.token, period_start)
                @puzzles_count = puzzles.length
                @target = 3
                @puzzle_target = 25
                games = game_response.split("\n")
                @games_played = [games.length, @target].min
                @reviews_count = reviews.length
            else
                redirect_to('/authorize')
            end
        else
            redirect_to('/users/sign_in')
        end
    end
    def review
    end
end
