# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin_all_from "app/javascript/config", under: "config"
pin "@rails/actioncable", to: "actioncable.esm.js", preload: true
pin "morphdom" # @2.7.3
pin "cable_ready", to: "cable_ready.js", preload: true
pin "stimulus_reflex", to: "stimulus_reflex.js", preload: true
pin "mrujs" # @1.0.0
pin "mrujs/plugins", to: "mrujs--plugins.js" # @1.0.0
pin "postcss-import" # @16.1.0
pin "buffer" # @2.0.1
pin "fs" # @2.0.1
pin "function-bind" # @1.1.2
pin "hasown" # @2.0.2
pin "is-core-module" # @2.14.0
pin "nanoid/non-secure", to: "nanoid--non-secure.js" # @3.3.7
pin "os" # @2.0.1
pin "path" # @2.0.1
pin "path-parse" # @1.0.7
pin "picocolors" # @1.0.1
pin "pify" # @2.3.0
pin "postcss" # @8.4.39
pin "postcss-value-parser" # @4.2.0
pin "process" # @2.0.1
pin "read-cache" # @1.0.0
pin "resolve" # @1.22.8
pin "source-map-js" # @1.2.0
pin "sugarss" # @4.0.1
pin "url" # @2.0.1
pin "@tailwindcss/forms", to: "@tailwindcss--forms.js" # @0.5.7
pin "mini-svg-data-uri" # @1.4.4
pin "tailwindcss/colors", to: "tailwindcss--colors.js" # @3.4.6
pin "tailwindcss/defaultTheme", to: "tailwindcss--defaultTheme.js" # @3.4.6
pin "tailwindcss/plugin", to: "tailwindcss--plugin.js" # @3.4.6
pin "debounce" # @2.1.0
pin "tom-select" # @2.3.1
