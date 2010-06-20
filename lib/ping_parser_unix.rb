require 'ping_result'

class PingParserUnix < PingResult
  def self.parse(output)
    new(output)
  end

  private

  def initialize(ping_output)
    ping_lines = ping_output.split("\n")
    ping_lines.each do |line|
      case line
      when /PING/
        set_dst_ip_from_ping_line(line)
      when /packets transmitted/
        set_packet_info_from_packet_line(line)
      when /stddev/
        set_stats_from_stats_line(line)
      end
    end
  end

  def set_dst_ip_from_ping_line(ping_line)
    ping_line =~ /\(((?:\d{1,3}\.){3}\d{1,3})\)/
    @dst_ip = $1
  end

  def set_packet_info_from_packet_line(packet_line)
    packet_line =~ /(\d+) packets transmitted, (\d+) packets received, (\d+\.\d+)% packet loss/
    @transmitted = $1.to_i
    @received = $2.to_i
    @loss_percentage = $3.to_f
  end

  def set_stats_from_stats_line(stats_line)
    stats_line =~ /round-trip min\/avg\/max\/stddev = (.*) ms/
    @min, @avg, @max, @stddev = $1.split("/").map { |n| n.to_f }
  end
end
