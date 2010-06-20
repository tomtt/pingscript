require 'json'

class PingResult
  ATTRIBUTES = [:avg, :dst_ip, :loss_percentage, :max, :min, :received, :stddev, :transmitted]
  attr_reader *ATTRIBUTES

  def to_json
    result_data = {}
    ATTRIBUTES.each do |attribute|
      result_data[attribute] = send(attribute)
    end
    result_data.to_json
  end
end
