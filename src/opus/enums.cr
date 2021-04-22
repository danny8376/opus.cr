require "./lib_opus"

module Opus
  enum Application
    VoIP 								= LibOpus::OPUS_APPLICATION_VOIP
    Audio 							= LibOpus::OPUS_APPLICATION_AUDIO
    RestrictedLowDelay 	= LibOpus::OPUS_APPLICATION_RESTRICTED_LOWDELAY
  end

  enum Bandwidth
    Auto          = LibOpus::OPUS_AUTO
    Narrowband    = LibOpus::OPUS_BANDWIDTH_NARROWBAND
    Mediumband    = LibOpus::OPUS_BANDWIDTH_MEDIUMBAND
    Wideband      = LibOpus::OPUS_BANDWIDTH_WIDEBAND
    Superwideband = LibOpus::OPUS_BANDWIDTH_SUPERWIDEBAND
    Fullband      = LibOpus::OPUS_BANDWIDTH_FULLBAND 
  end

  enum ForceChannels
    Auto    = LibOpus::OPUS_AUTO
    Mono    = 1
    Stereo  = 2
  end

  enum Signal
    Auto = LibOpus::OPUS_AUTO
    Voice = LibOpus::OPUS_SIGNAL_VOICE
    Music = LibOpus::OPUS_SIGNAL_MUSIC
  end

  enum FrameDuration
    FramesizeArg    = LibOpus::OPUS_FRAMESIZE_ARG
    Framesize2_5MS  = LibOpus::OPUS_FRAMESIZE_2_5_MS
    Framesize5MS    = LibOpus::OPUS_FRAMESIZE_5_MS
    Framesize10MS   = LibOpus::OPUS_FRAMESIZE_10_MS
    Framesize20MS   = LibOpus::OPUS_FRAMESIZE_20_MS
    Framesize40MS   = LibOpus::OPUS_FRAMESIZE_40_MS
    Framesize60MS   = LibOpus::OPUS_FRAMESIZE_60_MS
    Framesize80MS   = LibOpus::OPUS_FRAMESIZE_80_MS
    Framesize100MS  = LibOpus::OPUS_FRAMESIZE_100_MS
    Framesize120MS  = LibOpus::OPUS_FRAMESIZE_120_MS
  end
end
