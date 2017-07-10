export class CounterChannel {
  constructor(app, counter, eventHandler) {
    app.socket.connect()

    this.counter = counter
    this.eventHandler = eventHandler

    this.channel = app.socket.channel(counter.channelId, {})
    this.channel.on("counter_incremented", data => this.onCounterIncremented(data))

    this.channel.join()
      .receive("ok", counter => {
        console.log("Channel joined successfully", counter)
        this.counter.update(counter)
        this.eventHandler.channelStateChanged()
        this.retryUnconfirmed()
      })

    this.channel.onError(() => {
      console.log("Channel connection dropped")
      this.eventHandler.channelStateChanged()
    })
  }

  retryUnconfirmed() {
    const ids = Object.keys(this.counter.unconfirmedIncrements)
    for (const id of ids) {
      this.incrementCounter(id)
    }
  }

  incrementCounter(incrementId) {
    this.channel.push("increment_counter", { id: incrementId })
  }

  onCounterIncremented({ counter, increment }) {
    this.counter.confirmAndUpdate(counter, increment)
  }
}
