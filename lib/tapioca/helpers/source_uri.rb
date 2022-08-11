# typed: true
# frozen_string_literal: true

require "uri/file"

module URI
  class Source < URI::File
    extend T::Sig

    COMPONENT = T.let([
      :scheme,
      :gem_name,
      :gem_version,
      :path,
      :line_number,
    ].freeze, T::Array[Symbol])

    alias_method(:gem_name, :host)
    alias_method(:line_number, :fragment)

    sig { returns(String) }
    attr_reader :gem_version

    sig { params(v: T.nilable(String)).void }
    def set_path(v) # rubocop:disable Naming/AccessorMethodName
      return if v.nil?

      @gem_version, @path = v.delete_prefix("/").split("/", 2)
    end

    sig { returns(String) }
    def to_s
      "source://#{gem_name}/#{gem_version}/#{path}##{line_number}"
    end

    if respond_to?(:register_scheme)
      URI.register_scheme("SOURCE", self)
    else
      @@schemes["SOURCE"] = self
    end
  end
end
