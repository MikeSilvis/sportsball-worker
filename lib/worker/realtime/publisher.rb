require 'pusher'

class Realtime::Publisher
  def self.send_boxscore(league, game_id)
    game_id = game_id.to_s
    boxscore = Boxscore.find(league, game_id)
    game = League.new(league).scores(boxscore.game_date.to_date).detect { |s| s.boxscore == game_id }

    return unless game && boxscore

    push_event("boxscore_#{league}_#{game_id}", {
      boxscore: boxscore,
      game: game
    })
  end

  def self.send_scores(league)
    date = ActiveSupport::TimeZone['America/New_York'].today
    scores = League.new(league).scores(date)

    push_event("scores_#{league}", {
      scores: scores
    })
  end

  private

  def self.push_event(channel, data)
    Realtime.client.trigger(channel, 'event', data)
  end
end
