import { groupBy } from "lodash-es"
import people from "./people"
import '../stylesheets/people_page.scss'

const managerGroups = groupBy(people, "manager")
const root = document.createElement("div")

root.innerHTML = `<p>Hello Webpack.</p>`
root.innerHTML += `<pre>${JSON.stringify(managerGroups, null, 2)}</pre>`
root.innerHTML += `<pre>Load on demand for people page</pre>`

document.body.appendChild(root)
