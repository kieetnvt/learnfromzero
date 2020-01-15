import '../stylesheets/welcome_index.scss'

const root = document.createElement("div")

root.innerHTML = `<p>Hello Webpack.</p>`
root.innerHTML += `<pre>Load on demand for welcome index page</pre>`

document.body.appendChild(root)
