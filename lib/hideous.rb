require "hideous/version"

module Hideous

  def obfuscate_id(options = {})
    require 'hideous/xor_knuth_hash'
    extend ClassMethods
    include InstanceMethods
    cattr_accessor :hideous_prime
    cattr_accessor :hideous_prime_inverse
    cattr_accessor :hideous_rndxor
    self.hideous_prime = (options[:prime] || hideous_default_prime)
    self.hideous_prime_inverse = (options[:prime_inverse] || hideous_default_prime_inverse)
    self.hideous_rndxor = (options[:rndxor] || hideous_default_rndxor)
  end

  def self.hide(id, hideous_prime, hideous_prime_inverse, hideous_rndxor)
    XorKnuthHash.hash(id, hideous_prime, hideous_prime_inverse, hideous_rndxor)
  end

  def self.show(id, hideous_prime, hideous_prime_inverse, hideous_rndxor)
    XorKnuthHash.reverse_hash(id, hideous_prime, hideous_prime_inverse, hideous_rndxor)
  end


  module ClassMethods
    def find(*args)
      if has_obfuscated_id?
        args[0] = Hideous.show(args[0], self.hideous_prime, self.hideous_prime_inverse, self.hideous_rndxor)
      end
      super(*args)
    end

    def has_obfuscated_id?
      true
    end

    def hideous_default_prime
      413_158_511
    end

    def hideous_default_prime_inverse
      1_711_444_623
    end

    def hideous_default_rndxor
      652_109_907
    end
  end

  module InstanceMethods
    def to_param
      Hideous.hide(self.id, self.hideous_prime, self.hideous_prime_inverse, self.hideous_rndxor)
    end

  end

end

ActiveRecord::Base.extend Hideous
