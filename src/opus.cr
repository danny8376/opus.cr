# TODO: Write documentation for `Opus`
require "./opus/*"

module Opus
  VERSION = "0.1.0"

  FRAME_SIZE = 960
  MAX_FRAME_SIZE = 6 * FRAME_SIZE
  MAX_PACKET_SIZE = 3 * 1276

  def self.pcm_soft_clip(pcm : Slice(Float), frame_size, channels)
    states = Slice(Float).new(channels)
    LibOpus.opus_pcm_soft_clip(pcm, frame_size, channels, pointerof(state))
    {pcm, states}
  end
end
