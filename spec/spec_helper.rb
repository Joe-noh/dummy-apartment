#-*- coding: utf-8 -*-

lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'dummy-apartment'

module Build
  def [](*args)
    apartment = DummyApartment.generate
    args.each_with_object([]) { |arg, array|
      array << apartment.send(arg)
    }
  end

  def method_missing(name, *args)
    DummyApartment.generate.send(name, *args)
  end

  module_function :[], :method_missing
end
