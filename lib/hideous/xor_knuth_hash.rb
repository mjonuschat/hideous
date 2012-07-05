class XorKnuthHash
  MAXID = 2147483647
  # Convience class method pointing to the instance method
  def self.hash(record_id, prime, prime_inverse, rndxor)
    new(record_id, prime, prime_inverse, rndxor).hash
  end

  # Convience class method pointing to the instance method
  def self.reverse_hash(hash, prime, prime_inverse, rndxor)
    new(hash, prime, prime_inverse, rndxor).reverse_hash
  end

  def self.calculate_prime_inverse(prime)
    self.modinv(prime, MAXID+1)
  end

  def initialize(id_or_hash, prime, prime_inverse, rndxor)
    @id_or_hash = id_or_hash
    @prime = prime
    @prime_inverse = prime_inverse
    @rndxor = rndxor
  end

  # obfuscates an integer
  def hash
    (((@id_or_hash * @prime) & MAXID) ^ @rndxor).to_s(16)
  end

  # de-obfuscates an integer
  def reverse_hash
    ((@id_or_hash.to_i(16) ^ @rndxor) * @prime_inverse) & MAXID
  end

  private

  # Modular inverse
  # Returns x so that ax ≡ 1 (mod m)
  def self.modinv(a, m)
    x, y, g = egcd(a, m)
    if g==1
      return x%m
    else
      return nil
    end
  end

  # Extended great common divisor
  # Returns x, y and gcd(a,b) so that ax + by = gcd(a,b)
  def self.egcd(a, b)
    x, x1, y, y1 = 1, 0, 0, 1
    while b!=0
      q = a/b
      x, x1 = x1, x-q*x1
      y, y1 = y1, y-q*y1
      a, b  =  b, a-q*b
    end
    return x, y, a
  end
end
