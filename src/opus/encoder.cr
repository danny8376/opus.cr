require "./macros"

module Opus
  class Encoder
    getter sample_rate, channels

    def initialize(@sample_rate = 48000, @channels = 2, application = Application::Audio)
      error = LibOpus::OPUS_OK
      @encoder = LibOpus.opus_encoder_create(@sample_rate, @channels, application, pointerof(error))
      @output = Bytes.new MAX_PACKET_SIZE
      raise Error.new(error) unless error == LibOpus::OPUS_OK
    end

    def finalize
      LibOpus.opus_encoder_destroy(@encoder)
    end

    def encode(pcm : Slice(Int16), frame_size)
      size = LibOpus.opus_encode(@encoder, pcm, frame_size, @output, @output.bytesize)
      raise Error.new(size) if size < 0
      @output[0, size].dup # we need to return copied one
    end

    def encode(pcm_bytes : Bytes, frame_size)
      pcm = Slice(Int16).new(pcm_bytes.to_unsafe.as(Int16*), pcm_bytes.bytesize // 2) # assume that endian matches system endian
      encode(pcm, frame_size)
    end

    def encode(pcm : Slice(Float), frame_size)
      size = LibOpus.opus_encode_float(@encoder, pcm, frame_size, @output, @output.bytesize)
      raise Error.new(size) if size < 0
      @output[0, size].dup # we need to return copied one
    end

    # ==== Generic ====

    def reset
      LibOpus.opus_encoder_ctl(@encoder, LibOpus::OPUS_RESET_STATE)
    end

    Opus.opus_getter encoder, bandwidth, enum_name: Bandwidth
    Opus.opus_setter encoder, bandwidth, enum_name: Bandwidth
    Opus.opus_getter encoder, phase_inversion, opus_name: PHASE_INVERSION_DISABLED, reverse_bool: true
    Opus.opus_setter encoder, phase_inversion, opus_name: PHASE_INVERSION_DISABLED, reverse_bool: true
    Opus.opus_getter encoder, in_dtx, is_bool: true

    # ==== Encoder Specific ====

    Opus.opus_getter encoder, complexity
    Opus.opus_setter encoder, complexity
    Opus.opus_getter encoder, bitrate
    Opus.opus_setter encoder, bitrate
    Opus.opus_getter encoder, vbr, is_bool: true
    Opus.opus_setter encoder, vbr, is_bool: true
    Opus.opus_getter encoder, constrained_vbr, opus_name: VBR_CONSTRAINT, is_bool: true
    Opus.opus_setter encoder, constrained_vbr, opus_name: VBR_CONSTRAINT, is_bool: true
    Opus.opus_getter encoder, force_channels, enum_name: ForceChannels
    Opus.opus_setter encoder, force_channels, enum_name: ForceChannels
    Opus.opus_getter encoder, max_bandwidth, enum_name: Bandwidth
    Opus.opus_setter encoder, max_bandwidth, enum_name: Bandwidth
    Opus.opus_getter encoder, signal, enum_name: Signal
    Opus.opus_setter encoder, signal, enum_name: Signal
    Opus.opus_getter encoder, application, enum_name: Application
    Opus.opus_setter encoder, application, enum_name: Application
    Opus.opus_getter encoder, lookahead
    Opus.opus_getter encoder, inband_fec, is_bool: true
    Opus.opus_setter encoder, inband_fec, is_bool: true
    Opus.opus_getter encoder, packet_loss_perc
    Opus.opus_setter encoder, packet_loss_perc
    Opus.opus_getter encoder, dtx, is_bool: true
    Opus.opus_setter encoder, dtx, is_bool: true
    Opus.opus_getter encoder, lsb_depth
    Opus.opus_setter encoder, lsb_depth
    Opus.opus_getter encoder, expert_frame_duration, enum_name: FrameDuration
    Opus.opus_setter encoder, expert_frame_duration, enum_name: FrameDuratio 
    Opus.opus_getter encoder, prediction, opus_name: PREDICTION_DISABLED, reverse_bool: true
    Opus.opus_setter encoder, prediction, opus_name: PREDICTION_DISABLED, reverse_bool: true
  end
end
