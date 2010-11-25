module FreeberryAuth
  module Version
    MAJOR = 0
    MINOR = 0
    RELEASE = 2

    def self.dup
      "#{MAJOR}.#{MINOR}.#{RELEASE}"
    end
  end
end
