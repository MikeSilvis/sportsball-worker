require 'json'
require 'faraday'
require 'pusher'

class Realtime::Publisher
  DEFAULT_API_URL = 'http://api.jumbotron.io/'

  def self.send_boxscore(league, game_id)
    game_id = game_id.to_s
    game = get_data("leagues/#{league}/scores")['scores'].detect { |s| s['boxscore'] == game_id }
    boxscore = get_data("leagues/#{league}/boxscores/#{game_id}")

    return unless game && boxscore

    push_event("boxscore_#{league}_#{game_id}", {
      boxscore: boxscore,
      game: game
    })
  end

  def self.send_scores(league)
    date = ActiveSupport::TimeZone['America/New_York'].today
    scores = get_data("leagues/#{league}/scores?date=#{date}")['scores']

    push_event("scores_#{league}", {
      scores: scores
    })
  end

  private

  def self.push_event(channel, data)
    Realtime.client.trigger(channel, 'event', data)
  end

  def self.get_data(path)
    JSON.parse(Faraday.get("#{DEFAULT_API_URL}/#{path}").body)
  end
end
