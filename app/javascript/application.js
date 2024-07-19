// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"
import "config"
import "channels"
import { CableCar } from "mrujs/plugins"
import mrujs from "mrujs"

mrujs.start({
  plugins: [
    new CableCar(CableReady)
  ]
})
