#
# http://codepen.io/owlookit/pen/JoGxwZ
#

console.log 'clock.js loaded!'

shifter = (val) ->
  [
    val
    cx
    cy
  ].join " "

hands = []
hands.push document.querySelector("#secondhand > *")
hands.push document.querySelector("#minutehand > *")
hands.push document.querySelector("#hourhand > *")
cx = 100
cy = 100
date = new Date()
hoursAngle = 360 * date.getHours() / 12 + date.getMinutes() / 2
minuteAngle = 360 * date.getMinutes() / 60
secAngle = 360 * date.getSeconds() / 60
hands[0].setAttribute "from", shifter(secAngle)
hands[0].setAttribute "to", shifter(secAngle + 360)
hands[1].setAttribute "from", shifter(minuteAngle)
hands[1].setAttribute "to", shifter(minuteAngle + 360)
hands[2].setAttribute "from", shifter(hoursAngle)
hands[2].setAttribute "to", shifter(hoursAngle + 360)
i = 1

while i <= 12
  el = document.createElementNS("http://www.w3.org/2000/svg", "line")
  el.setAttribute "x1", "100"
  el.setAttribute "y1", "30"
  el.setAttribute "x2", "100"
  el.setAttribute "y2", "40"
  el.setAttribute "transform", "rotate(" + (i * 360 / 12) + " 100 100)"
  el.setAttribute "style", "stroke: #ffffff;"
  document.querySelector("svg").appendChild el
  i++