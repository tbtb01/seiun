module Seiun
  module XMLParsers
    class ResultXML < Base
      class << self
        def each(xml_str, find_tag: "result", &block)
          parse(xml_str, find_tag, block)
        end
      end

      def result_id
        return unless result.is_a?(String)
        result
      end

      [ :id, :success, :created ].each do |name|
        define_method name do
          return unless result.is_a?(Hash)
          result[Seiun::Utils.camelize(name)]
        end
      end

      private

      def result
        if @attrs.size == 1 && @attrs.first.is_a?(String)
          @attrs.first
        else
          to_hash
        end
      end
    end
  end
end
