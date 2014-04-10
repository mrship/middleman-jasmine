require "middleman/jasmine/version"

::Middleman::Extensions.register(:jasmine) do
  require "middleman/jasmine/extension"
  ::Middleman::JasmineExtension
end
