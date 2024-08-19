import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="select2"
export default class extends Controller {
  connect() {
    new TomSelect('.select2',{});
  }
}
