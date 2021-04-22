require "./macros"

module Opus
  class Decoder
    getter sample_rate, channels

    def initialize(@sample_rate = 48000, @channels = 2)
      error = LibOpus::OPUS_OK
      @decoder = LibOpus.opus_decoder_create(@sample_rate, @channels, pointerof(error))
      raise Error.new(error) unless error == LibOpus::OPUS_OK
    end

    def finalize
      LibOpus.opus_decoder_destroy(@decoder)
    end

    def decode(packet : Packet)
      decode packet.data
    end

    def decode(payload : Bytes)
      @output_int ||= Slice(Int16).new @channels * MAX_FRAME_SIZE
      size = LibOpus.opus_decode(@decoder, payload, payload.bytesize, @output_int.not_nil!, MAX_FRAME_SIZE, 0) # ignore fec
      raise Error.new(size) if size < 0
      @output_int.not_nil![0, size * @channels].dup # we need to return copied one
    end

    def decode_float(packet : Packet)
      decode_float packet.data
    end

    def decode_float(payload : Bytes)
      @output_float ||= Slice(Float).new @channels * MAX_FRAME_SIZE
      size = LibOpus.opus_decode_float(@decoder, payload, payload.bytesize, @output_float.not_nil!, MAX_FRAME_SIZE, 0) # ignore fec
      raise Error.new(size) if size < 0
      @output_float.not_nil![0, size * @channels].dup # we need to return copied one
    end

    def samples(packet : Packet)
      samples packet.data
    end

    def samples(payload : Bytes)
      val = LibOpus.opus_decoder_get_nb_samples(@decoder, payload, payload.bytesize)
      raise Error.new(val) if val < 0
      val
    end

    # ==== Generic ====

    def reset
      LibOpus.opus_encoder_ctl(@encoder, LibOpus::OPUS_RESET_STATE)
    end

    Opus.opus_getter decoder, bandwidth, enum_name: Bandwidth
    Opus.opus_getter decoder, phase_inversion, opus_name: PHASE_INVERSION_DISABLED, reverse_bool: true
    Opus.opus_setter decoder, phase_inversion, opus_name: PHASE_INVERSION_DISABLED, reverse_bool: true
    Opus.opus_getter decoder, in_dtx, is_bool: true

    # ==== Decoder Specific ====

    Opus.opus_getter encoder, gain
    Opus.opus_setter encoder, gain
    Opus.opus_getter encoder, last_packet_duration
    Opus.opus_getter encoder, pitch
  end
end
