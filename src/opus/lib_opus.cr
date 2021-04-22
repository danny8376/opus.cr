@[Link("opus")]
lib LibOpus
  OPUS_OK = 0
  OPUS_BAD_ARG = -1
  OPUS_BUFFER_TOO_SMALL = -2
  OPUS_INTERNAL_ERROR = -3
  OPUS_INVALID_PACKET = -4
  OPUS_UNIMPLEMENTED = -5
  OPUS_INVALID_STATE = -6
  OPUS_ALLOC_FAIL = -7

  OPUS_RESET_STATE = 4028

  OPUS_SET_APPLICATION_REQUEST = 4000
  OPUS_GET_APPLICATION_REQUEST = 4001
  OPUS_SET_BITRATE_REQUEST = 4002
  OPUS_GET_BITRATE_REQUEST = 4003
  OPUS_SET_MAX_BANDWIDTH_REQUEST = 4004
  OPUS_GET_MAX_BANDWIDTH_REQUEST = 4005
  OPUS_SET_VBR_REQUEST = 4006
  OPUS_GET_VBR_REQUEST = 4007
  OPUS_SET_BANDWIDTH_REQUEST = 4008
  OPUS_GET_BANDWIDTH_REQUEST = 4009
  OPUS_SET_COMPLEXITY_REQUEST = 4010
  OPUS_GET_COMPLEXITY_REQUEST = 4011
  OPUS_SET_INBAND_FEC_REQUEST = 4012
  OPUS_GET_INBAND_FEC_REQUEST = 4013
  OPUS_SET_PACKET_LOSS_PERC_REQUEST = 4014
  OPUS_GET_PACKET_LOSS_PERC_REQUEST = 4015
  OPUS_SET_DTX_REQUEST = 4016
  OPUS_GET_DTX_REQUEST = 4017
  OPUS_SET_VBR_CONSTRAINT_REQUEST = 4020
  OPUS_GET_VBR_CONSTRAINT_REQUEST = 4021
  OPUS_SET_FORCE_CHANNELS_REQUEST = 4022
  OPUS_GET_FORCE_CHANNELS_REQUEST = 4023
  OPUS_SET_SIGNAL_REQUEST = 4024
  OPUS_GET_SIGNAL_REQUEST = 4025
  OPUS_GET_LOOKAHEAD_REQUEST = 4027
  OPUS_GET_SAMPLE_RATE_REQUEST = 4029
  OPUS_GET_FINAL_RANGE_REQUEST = 4031
  OPUS_GET_PITCH_REQUEST = 4033
  OPUS_SET_GAIN_REQUEST = 4034
  OPUS_GET_GAIN_REQUEST = 4045
  OPUS_SET_LSB_DEPTH_REQUEST = 4036
  OPUS_GET_LSB_DEPTH_REQUEST = 4037
  OPUS_GET_LAST_PACKET_DURATION_REQUEST = 4039
  OPUS_SET_EXPERT_FRAME_DURATION_REQUEST = 4040
  OPUS_GET_EXPERT_FRAME_DURATION_REQUEST = 4041
  OPUS_SET_PREDICTION_DISABLED_REQUEST = 4042
  OPUS_GET_PREDICTION_DISABLED_REQUEST = 4043
  OPUS_SET_PHASE_INVERSION_DISABLED_REQUEST = 4046
  OPUS_GET_PHASE_INVERSION_DISABLED_REQUEST = 4047
  OPUS_GET_IN_DTX_REQUEST = 4049

  OPUS_AUTO = -1000
  OPUS_BITRATE_MAX = -1
  OPUS_APPLICATION_VOIP = 2048
  OPUS_APPLICATION_AUDIO = 2049
  OPUS_APPLICATION_RESTRICTED_LOWDELAY = 2051
  OPUS_SIGNAL_VOICE = 3001
  OPUS_SIGNAL_MUSIC = 3002
  OPUS_BANDWIDTH_NARROWBAND = 1101
  OPUS_BANDWIDTH_MEDIUMBAND = 1102
  OPUS_BANDWIDTH_WIDEBAND = 1103
  OPUS_BANDWIDTH_SUPERWIDEBAND = 1104
  OPUS_BANDWIDTH_FULLBAND = 1105
  OPUS_FRAMESIZE_ARG = 5000
  OPUS_FRAMESIZE_2_5_MS = 5001
  OPUS_FRAMESIZE_5_MS = 5002
  OPUS_FRAMESIZE_10_MS = 5003
  OPUS_FRAMESIZE_20_MS = 5004
  OPUS_FRAMESIZE_40_MS = 5005
  OPUS_FRAMESIZE_60_MS = 5006
  OPUS_FRAMESIZE_80_MS = 5007
  OPUS_FRAMESIZE_100_MS = 5008
  OPUS_FRAMESIZE_120_MS = 5009

  fun opus_strerror(error : LibC::Int) : LibC::Char*
  fun opus_get_version_string : LibC::Char*

  alias OpusInt32 = LibC::Int
  alias OpusInt16 = LibC::Short
  type OpusEncoder = Void
  type OpusDecoder = Void
  type OpusRepacketizer = Void

  fun opus_encoder_get_size(channels : LibC::Int) : LibC::Int
  fun opus_encoder_create(fs : OpusInt32, channels : LibC::Int, application : LibC::Int, error : LibC::Int*) : OpusEncoder*
  fun opus_encoder_init(st : OpusEncoder*, fs : OpusInt32, channels : LibC::Int, application : LibC::Int) : LibC::Int
  fun opus_encode(st : OpusEncoder*, pcm : OpusInt16*, frame_size : LibC::Int, data : UInt8*, max_data_bytes : OpusInt32) : OpusInt32
  fun opus_encode_float(st : OpusEncoder*, pcm : LibC::Float*, frame_size : LibC::Int, data : UInt8*, max_data_bytes : OpusInt32) : OpusInt32
  fun opus_encoder_destroy(st : OpusEncoder*)
  fun opus_encoder_ctl(st : OpusEncoder*, request : LibC::Int, ...) : LibC::Int

  fun opus_decoder_get_size(channels : LibC::Int) : LibC::Int
  fun opus_decoder_create(fs : OpusInt32, channels : LibC::Int, error : LibC::Int*) : OpusDecoder*
  fun opus_decoder_init(st : OpusDecoder*, fs : OpusInt32, channels : LibC::Int) : LibC::Int
  fun opus_decode(st : OpusDecoder*, data : UInt8*, len : OpusInt32, pcm : OpusInt16*, frame_size : LibC::Int, decode_fec : LibC::Int) : LibC::Int
  fun opus_decode_float(st : OpusDecoder*, data : UInt8*, len : OpusInt32, pcm : LibC::Float*, frame_size : LibC::Int, decode_fec : LibC::Int) : LibC::Int
  fun opus_decoder_ctl(st : OpusDecoder*, request : LibC::Int, ...) : LibC::Int
  fun opus_decoder_destroy(st : OpusDecoder*)

  fun opus_packet_parse(data : UInt8*, len : OpusInt32, out_toc : UInt8*, frames : UInt8*[48], size : OpusInt16[48], payload_offset : LibC::Int*) : LibC::Int
  fun opus_packet_get_bandwidth(data : UInt8*) : LibC::Int
  fun opus_packet_get_samples_per_frame(data : UInt8*, fs : OpusInt32) : LibC::Int
  fun opus_packet_get_nb_channels(data : UInt8*) : LibC::Int
  fun opus_packet_get_nb_frames(packet : UInt8*, len : OpusInt32) : LibC::Int
  fun opus_packet_get_nb_samples(packet : UInt8*, len : OpusInt32, fs : OpusInt32) : LibC::Int
  fun opus_decoder_get_nb_samples(dec : OpusDecoder*, packet : UInt8*, len : OpusInt32) : LibC::Int
  fun opus_pcm_soft_clip(pcm : LibC::Float*, frame_size : LibC::Int, channels : LibC::Int, softclip_mem : LibC::Float*)

  fun opus_repacketizer_get_size : LibC::Int
  fun opus_repacketizer_init(rp : OpusRepacketizer*) : OpusRepacketizer*
  fun opus_repacketizer_create : OpusRepacketizer*
  fun opus_repacketizer_destroy(rp : OpusRepacketizer*)
  fun opus_repacketizer_cat(rp : OpusRepacketizer*, data : UInt8*, len : OpusInt32) : LibC::Int
  fun opus_repacketizer_out_range(rp : OpusRepacketizer*, begin : LibC::Int, _end : LibC::Int, data : UInt8*, maxlen : OpusInt32) : OpusInt32
  fun opus_repacketizer_get_nb_frames(rp : OpusRepacketizer*) : LibC::Int
  fun opus_repacketizer_out(rp : OpusRepacketizer*, data : UInt8*, maxlen : OpusInt32) : OpusInt32

  fun opus_packet_pad(data : UInt8*, len : OpusInt32, new_len : OpusInt32) : LibC::Int
  fun opus_packet_unpad(data : UInt8*, len : OpusInt32) : OpusInt32

  fun opus_multistream_packet_pad(data : UInt8*, len : OpusInt32, new_len : OpusInt32, nb_streams : LibC::Int) : LibC::Int
  fun opus_multistream_packet_unpad(data : UInt8*, len : OpusInt32, nb_streams : LibC::Int) : OpusInt32
end
