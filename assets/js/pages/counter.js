import { leftPad } from "../pad"

export class CounterPage {
  constructor($, elem) {
    this.elem = elem

    this.counterId = elem.dataset['id']
    this.channelId = elem.dataset['channelId']

    this.channel = new CounterChannel(this.channelId, this)

    this.valueElem = $.one('.counter__value')
    this.formElem = $.one('form')

    this.formElem.addEventListener('submit', (e) => this.onFormSubmit(e))
  }

  static locate($) {
    const counterElem = $.one('.counter')
    return counterElem ? new CounterPage($, counterElem) : null
  }

  init(socket) {
    this.channel.join(socket)
  }

  onFormSubmit(event) {
    event.preventDefault()
    this.channel.incrementCounter()
  }

  onCounterIncremented({ value }) {
    this.valueElem.innerText = this.formatValue(value)
  }

  formatValue(value) {
    return leftPad(value.toString(), "0", 5)
  }
}

export class CounterChannel {
  constructor(channelId, eventHandler) {
   this.channelId = channelId
   this.eventHandler = eventHandler
  }

  join(socket) {
    this.channel = socket.channel(this.channelId, {})
    this.channel.on("counter_incremented", resp => {
      console.log("Received 'counter_incremented'", resp)
      this.eventHandler.onCounterIncremented(resp)
    })

    this.channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })
  }

  incrementCounter() {
    this.channel.push("increment_counter", {})
  }
}
