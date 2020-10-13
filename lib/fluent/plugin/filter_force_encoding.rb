#
# Copyright 2020- okkez
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/filter"

module Fluent
  module Plugin
    class ForceEncodingFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("force_encoding", self)

      helpers :record_accessor

      config_section :element, param_name: :elements, multi: true do
        desc "Specify field name in the record to force encode"
        config_param :key, :string
        desc "Encoding name"
        config_param :encoding, :string
      end

      def configure(conf)
        super

        @accessors = @elements.map do |element|
          [record_accessor_create(element.key), element.encoding]
        end
      end

      def filter(tag, time, record)
        @accessors.each do |accessor, encoding|
          raw_value = accessor.call(record)
          value = raw_value&.force_encoding(encoding) || raw_value
          accessor.set(record, value)
        end
        record
      end
    end
  end
end
