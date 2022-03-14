const field = document.getElementById("field");

const getUrl = (url) => {
    fetch(url).then((response) => {
        return response.json();
    }).then((data)=>{
        console.log(data);
    }).catch((err)=>{
        console.log("error: ", err);
    })
}


const main = ()=>{
    getUrl('http://localhost:8000/')
}

main();