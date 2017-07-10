import uuid4 from "uuid/v4"


export class Counter {
  constructor(id, value, channelId, eventHandler) {
    this.id = id
    this.confirmedValue = value
    this.channelId = channelId
    this.unconfirmedIncrements = {}
    this.eventHandler = eventHandler
  }

  get value() {
    return this.confirmedValue + Object.keys(this.unconfirmedIncrements).length
  }

  increment() {
    const incrementId = uuid4()
    this.unconfirmedIncrements[incrementId] = new Date()
    this.eventHandler.counterValueChanged()
    return incrementId
  }

  update(counterData) {
    this.confirmedValue = counterData.value
    this.eventHandler.counterValueChanged()
  }

  confirmAndUpdate(counterData, incrementData) {
    delete this.unconfirmedIncrements[incrementData.id]
    this.update(counterData)
  }

  hasUnconfirmedIncrements() {
    return Object.keys(this.unconfirmedIncrements).length > 0
  }
}




