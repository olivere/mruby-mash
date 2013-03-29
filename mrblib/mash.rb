##
# Mash
#

if Object.const_defined?(:Mash)
  class Mash

    ##
    # Calls the given block for each element of +self+
    # and pass the respective element.
    def each(&block)
      self.class.members.each{|field|
        block.call(self[field])
      }
      self
    end

    ##
    # Calls the given block for each element of +self+
    # and pass the name and value of the respectiev
    # element.
    def each_pair(&block)
      self.class.members.each{|field|
        block.call(field.to_sym, self[field])
      }
      self
    end

    ##
    # Calls the given block for each element of +self+
    # and returns an array with all elements of which
    # block is not false.
    def select(&block)
      ary = []
      self.class.members.each{|field|
        val = self[field]
        ary.push(val) if block.call(val)
      }
      ary
    end

    ##
    # Returns +self+ as Hash.
    def to_hash
      hsh = {}
      self.each_pair do |k,v|
        hsh[k] = v
      end
      hsh
    end

    def empty?
      self.class.members.size == 0
    end

    ##
    def method_missing(method_name, *args, &blk)
      if method_name.to_s[-1] == '?'
        self.class.members.any? { |k| k.to_s == method_name.to_s[0..-2] }
      else
        super(method_name, *args, &blk)
      end
    end
  end
end
