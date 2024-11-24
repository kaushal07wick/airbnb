import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition' 

export default class extends Controller {
  connect () {
    console.log("amenities controller connected")
  }
  
  toggleAmenitiesModal(){
    document.getElementById("amenities").click();
  }

}
