class Realtime::Checker
  def self.push_updates
    Realtime::Channel.all.each do |channel, _|
      params = channel.split('_')
      if params[0] == 'scores'
        Realtime::Publisher.send_scores(params[1])
      elsif params[0] == 'boxscore'
        Realtime::Publisher.send_boxscore(params[1], params[2])
      end
    end
  end
end
