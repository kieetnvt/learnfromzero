if (module.hot) {
  module.hot.accept()
}

import './app.scss'

const button = document.createElement("button")
button.textContent = 'Open chat'
document.body.appendChild(button)

button.onclick = () => {
  import("./chat").then(chat => {
    chat.init()
  })
}
