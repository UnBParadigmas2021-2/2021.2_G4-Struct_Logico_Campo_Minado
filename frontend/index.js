var linhas = 10, colunas = 10, bombas = 10, matriz, tabela;

const field = document.getElementById('field')

const getUrl = (url) => {
  fetch(url)
    .then((response) => {
      return response.json()
    })
    .then((data) => {
      console.log(data)
      matriz = data.mine
      console.log("Campo ---->", matriz)
    })
    .catch((err) => {
      console.log('error: ', err)
    })
}

getUrl('http://localhost:8000/get-mine')


function montaTd(dado, classe) {
  let td = document.createElement("td")
  td.textContent = dado
  td.classList.add(classe)

  return td
}

function gerarTabela(l, c) {
  console.log("Entrou no gera tabela")
  for (var i = 0; i < l; i++) {
    var tr = document.createElement("tr")
    tr.classList.add("linha");
    for (var j = 0; j < c; j++) {
      let td = document.createElement("td");
      td.classList.add("coluna");
      //console.log(matriz[i][j])
      td.textContent = matriz[i][j]
      tr.appendChild(td)
    }
    console.log(matriz[i][j])
    tabela.appendChild(tr)
  }
  console.log("Essa é a nova tabela ------>", tabela)
}

function init() {
  tabela = document.getElementById('CampoMinado');
  tabela.onclick = verificar;
  //tabela.oncontextmenu = bandeira;
  gerarTabela(linhas, colunas);
}

function verificar(event) {
  var cell = event.target;
  var linha = cell.parentNode.rowIndex;
  var coluna = cell.cellIndex;
  switch (matriz[linha][coluna]) {
    case -1:
      mostrarBombas();
      cell.style.backgroundColor = "red";
      tabela.onclick = undefined;
      tabela.oncontextmenu = undefined;
      alert("Você perdeu!");
      break;
    case 0:
      limparCelulas(linha, coluna);
      break;
    default:
      cell.innerHTML = matriz[linha][coluna];
      cell.className = "n" + matriz[linha][coluna];
  }
  fimDeJogo();

}

function limparCelulas(l, c) {
  for (var i = l - 1; i <= l + 1; i++) {
    for (var j = c - 1; j <= c + 1; j++) {
      if (i >= 0 && i < linhas && j >= 0 && j < colunas) {
        var cell = tabela.rows[i].cells[j];
        if (cell.className !== "blank") {
          switch (matriz[i][j]) {
            case -1:
              break;
            case 0:
              cell.innerHTML = "";
              cell.className = "blank";
              limparCelulas(i, j);
              break;
            default:
              cell.innerHTML = matriz[i][j];
              cell.className = "n" + matriz[i][j];
          }
        }
      }
    }
  }
}

/* function bandeira(event) {
  var cell = event.target;
  var linha = cell.parentNode.rowIndex;
  var coluna = cell.cellIndex;
  if (cell.className === "blocked") {
    cell.className = "flag";
    cell.innerHTML = "&#128681;";//&#9873;
  } else if (cell.className === "flag") {
    cell.className = "blocked";
    cell.innerHTML = "";
  }
  return false;
} */

onload = init;
