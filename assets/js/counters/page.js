import { leftPad } from "../pad"
import { Counter } from "./counter"
import { CounterChannel } from "./channel"

export class CounterPage {

  constructor(app, elem) {
    this.elem = elem

    this.valueElem = app.selector.one('.counter__value')
    this.formElem = app.selector.one('form')

    const counterId = elem.dataset['counterId']
    const counterValue = parseInt(elem.dataset['counterValue'], 10)
    const channelId = elem.dataset['channelId']

    this.counter = new Counter(counterId, counterValue, channelId, this)
    this.channel = new CounterChannel(app, this.counter, this)

    this.formElem.addEventListener('submit', e => this.onFormSubmit(e))
  }

  onFormSubmit(event) {
    event.preventDefault()
    const incrementId = this.counter.increment()
    this.channel.incrementCounter(incrementId)
  }

  channelStateChanged() {
    console.log("Channel state changed", this.channel)
  }

  counterValueChanged() {
    this.renderValue()
  }

  renderValue() {
    const paddedValue = leftPad(this.counter.value.toString(), "0", 5)
    this.valueElem.innerText = paddedValue
  }
}
