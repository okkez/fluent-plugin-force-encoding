# fluent-plugin-force-encoding

[Fluentd](https://fluentd.org/) filter plugin to force encoding specified keys.


## Installation

### RubyGems

```
$ gem install fluent-plugin-force-encoding
```

### Bundler

Add following line to your Gemfile:

```ruby
gem "fluent-plugin-force-encoding"
```

And then execute:

```
$ bundle
```

## Configuration


```
<filter>
  <element>
    key host
    encoding us-ascii
  </element>
</filter>
```

This will call `String#force_encoding(encoding)` to the `host` field's value.

## Plugin helpers

* [record_accessor](https://docs.fluentd.org/v/1.0/plugin-helper-overview/api-plugin-helper-record_accessor)

* See also: [Filter Plugin Overview](https://docs.fluentd.org/v/1.0/filter#overview)

## Fluent::Plugin::ForceEncodingFilter configuration

### \<element\> section (optional) (multiple)

* **key** (string) (required): Specify field name in the record to force encode
* **encoding** (string) (required): Encoding name

## Copyright

* Copyright(c) 2020- okkez
* License
  * Apache License, Version 2.0
