import { Socket } from "phoenix"
import { createSelector } from "./selector"
import { CounterPage } from "./counters/page"


const PAGES = {
  'counter-show': CounterPage
}


function routePage(app) {
  const pageElem = app.selector.one('[data-page]')
  if (!pageElem) {
    return {}
  }

  const pageName = pageElem.dataset['page']
  const pageClass = PAGES[pageName]
  return new pageClass(app, pageElem)
}


function main() {
  const app = {
    selector: createSelector(document),
    socket: new Socket("/socket")
  }

  app.socket.connect()
  app.currentPage = routePage(app)
}


// Boot as soon as page is loaded
if (document.readyState === "loading") {
  document.addEventListener("DOMContentLoaded", main)
} else {
  setTimeout(main, 0)
}
