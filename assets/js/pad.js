export function leftPad(string, pad, minLength) {
  if (string.length >= minLength || pad.length <= 0) {
    return string
  }

  while (pad.length < minLength) {
      pad += pad;
  }

  return pad.substr(0, minLength - string.length) + string;
}
