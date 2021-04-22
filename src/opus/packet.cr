module Opus
  class Packet
    getter data : Bytes
    def initialize(@data)
    end

    def bandwidth
      val = Bandwidth.from_value LibOpus.opus_packet_get_bandwidth(@data)
      raise Error.new(val) if val < 0
      val
    end

    def samples_per_frame(sample_rate)
      val = LibOpus.opus_packet_get_samples_per_frame(@data, sample_rate)
      raise Error.new(val) if val < 0
      val
    end

    def channels
      val = LibOpus.opus_packet_get_nb_channels(@data)
      raise Error.new(val) if val < 0
      val
    end

    def frames
      val = LibOpus.opus_packet_get_nb_frames(@data, @data.bytesize)
      raise Error.new(val) if val < 0
      val
    end

    def samples(sample_rate)
      val = LibOpus.opus_packet_get_nb_samples(@data, @data.bytesize, sample_rate)
      raise Error.new(val) if val < 0
      val
    end
  end
end
