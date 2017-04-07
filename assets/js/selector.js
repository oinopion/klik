export function createSelector(document) {
  return {
    one: (selectors) => document.querySelector(selectors),
    all: (selectors) => docuemnt.querySelectorAll(selectors)
  }
}
