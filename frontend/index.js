var linhas = 10, colunas = 10, bombas = 10, matrix, tabela;
const field = document.getElementById('field')
var gameBotton = document.getElementById('init-game');
const flagIcon = '🚩'
var countBombs = 0

//Consome a API
const getUrl = (url) => {
  fetch(url)
    .then((response) => {
      return response.json()
    })
    .then((data) => {
      console.log(data)
      matrix = data.mine
      console.log("Campo ---->", matrix)
    })
    .catch((err) => {
      console.log('error: ', err)
    })
}

getUrl('http://localhost:8000/get-mine')


function gerarTabela(l, c) {
  for (var i = 0; i < l; i++) {
    var tr = document.createElement("tr")
    tr.classList.add("linha");
    for (var j = 0; j < c; j++) {
      let td = document.createElement("td");
      td.classList.add("coluna");
      tr.appendChild(td)
    }
    tabela.appendChild(tr)
  }
  console.log("Essa é a nova tabela ------>", tabela)
}

function init() {
  tabela = document.getElementById('field');
  tabela.onclick = verificar;
  tabela.oncontextmenu = toggleMarkFlag
  gerarTabela(linhas, colunas);
}

function toggleMarkFlag(event){
  event.preventDefault()
  var cell = event.target;
  if (cell.innerText === flagIcon)
    cell.innerHTML = ""
  else if (cell.innerHTML === "" && cell.style.backgroundColor !== "gray")
    cell.innerHTML = flagIcon
    cell.style.textAlign = "center";
}

function verificar(event) {
  var cell = event.target;
  var linha = cell.parentNode.rowIndex;
  var coluna = cell.cellIndex;

  if (cell.backgroundColor === "gray") 
    return

  switch (matrix[linha][coluna]) {
    case 9:
      mostrarBombas();
      cell.style.backgroundColor = "red";
      cell.style.textAlign = "center";
      tabela.onclick = undefined;
      tabela.oncontextmenu = undefined;
      alert("Você perdeu!");
      break;
    case 0:
      cell.style.backgroundColor = "gray"
      cell.style.textAlign = "center";
      countBombs+=1
      limparCelulas(linha, coluna);
      break;
    default:
      cell.innerHTML = matrix[linha][coluna];
      cell.style.backgroundColor = "gray"
      cell.style.textAlign = "center";
      countBombs+=1
  }
  fimDeJogo();

}

function limparCelulas(l, c) {
  for (var i = l - 1; i <= l + 1; i++) {
    for (var j = c - 1; j <= c + 1; j++) {
      if (i >= 0 && i < linhas && j >= 0 && j < colunas) {
        var cell = tabela.rows[i].cells[j];
        if (cell.style.backgroundColor != "gray" ) {
          switch (matrix[i][j]) {
            case 9:
              break;
            case 0:
              cell.innerHTML = "";
              cell.className = "coluna blank";
              cell.style.backgroundColor = "gray"
              cell.style.textAlign = "center";
              countBombs+=1
              limparCelulas(i, j);
              break;
            default:
              cell.innerHTML = matrix[i][j];
              cell.className = "n" + matrix[i][j];
              cell.style.backgroundColor = "gray"
              cell.style.textAlign = "center";
              countBombs+=1
          }
        }
      }
    }
  }
}

function mostrarBombas() {
  for (var i = 0; i < linhas; i++) {
    for (var j = 0; j < colunas; j++) {
      if (matrix[i][j] === 9) {
        var cell = tabela.rows[i].cells[j];
        cell.innerHTML = "&#128163;";
        cell.className = "blank";
        cell.style.textAlign = "center";
      }
    }
  }
}

function fimDeJogo() {
  console.log(countBombs)
  if (100 - countBombs <= bombas) {
    mostrarBombas();
    tabela.onclick = undefined;
    alert("Você venceu!");
  }
}

gameBotton.addEventListener("click", (event) => {
  event.preventDefault();
  console.log("fui clicado");
  location.reload();
})
onload = init;
