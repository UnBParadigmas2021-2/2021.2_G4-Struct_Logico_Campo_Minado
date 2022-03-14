const field = document.getElementById('field')

const getUrl = (url) => {
  fetch(url)
    .then((response) => {
      return response.json()
    })
    .then((data) => {
      console.log(data)
    })
    .catch((err) => {
      console.log('error: ', err)
    })
}

getUrl('http://localhost:8000/get-mine')
