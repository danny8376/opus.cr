module Opus
  class Error < Exception
    def initialize(error : LibC::Int, cause : Exception? = nil)
      message = String.new(LibOpus.opus_strerror(error))
      super(message, cause: cause)
    end
  end
end
