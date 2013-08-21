Sequel::Model.plugin :json_serializer
Sequel::Model.plugin :timestamps

class Streamer < Sequel::Model
  def after_create
    EM.chan.push self.to_json
    super
  end

  def after_update
    EM.chan.push self.to_json
    super
  end
end
