import { Controller } from "@hotwired/stimulus"
import flatpickr from 'flatpickr';

export default class extends Controller {
    static targets = ["numberOfNights", "baseFare", "serviceFee", "totalAmount", "checkin", "checkout"]

    SERVICE_FEE_PERCENT = 0.18;

    disableDates = [];

  connect() {
    this.formatBlockedDates();
    flatpickr(this.checkinTarget, {
      minDate: new Date().fp_incr(1),
      disable: this.disableDates,
      onChange: (selectedDates, dateStr, instance) => {
        this.triggerCheckoutDatePicker(selectedDates);
      },
    });
    this.updateDetails();
  }

  triggerCheckoutDatePicker(selectedDates){
    flatpickr(this.checkoutTarget, {
      minDate: new Date(selectedDates).fp_incr(1),
      disable: this.disableDates,
      onChange: (selectedDates, dateStr, instance) => {
        this.updateDetails();
      },
    });

    this.checkoutTarget.click();
  }

  formatBlockedDates(){
    const blockedDates = JSON.parse(this.element.dataset.blockedDates)
    
    for(let i=0; i < blockedDates.length; i++){
      const dates = blockedDates[i];
      this.disableDates.push(
        {
          from: dates[0], //checkin date
          to: dates[1],  //checkout date
        }
      )
    }
  }

  updateDetails(){
    const nightsCount = this.numberOfNights;
    const baseFareValue = this.calculateBaseFare(nightsCount);
    const serviceFeeValue = this.calculateServiceFee(baseFareValue);
    const totalAmount = this.calculateTotalAmount(baseFareValue, serviceFeeValue);

    this.numberOfNightsTarget.textContent = nightsCount;
    this.baseFareTarget.textContent = baseFareValue;
    this.serviceFeeTarget.textContent = serviceFeeValue;
    this.totalAmountTarget.textContent = totalAmount;
  }

  get numberOfNights(){
    const checkinDate = new Date (this.checkinTarget.value);
    const checkoutDate = new Date (this.checkoutTarget.value);
    return (checkoutDate - checkinDate)/(1000 * 60 * 60 * 24);
  }

  calculateBaseFare(nightsCount){
    return parseFloat((nightsCount * this.element.dataset.perNightPrice).toFixed(2));
  }

  calculateServiceFee(baseFareValue){
    return parseFloat((baseFareValue * this.SERVICE_FEE_PERCENT).toFixed(2));
  }

  calculateTotalAmount(baseFareValue, serviceFeeValue){
    return parseFloat((baseFareValue + serviceFeeValue).toFixed(2));
  }
}
