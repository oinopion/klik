import { Socket } from "phoenix"
import { createSelector } from "./selector"
import { CounterPage } from "./pages/counter"


function main() {
  const selector = createSelector(document)

  const counterPage = CounterPage.locate(selector)
  if (counterPage) {
    const socket = new Socket("/socket")
    socket.connect()

    counterPage.init(socket)
  }
}


// Boot as soon as page is loaded
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", main)
} else {
  setTimeout(main, 0)
}
