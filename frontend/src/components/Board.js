import React, { useState, useEffect } from "react";
import axios from 'axios';
function Board() {
  const [grid, setGrid] = useState([]);

  const style = {
    display: 'flex',
    flexDirection: 'row',

  }
  useEffect(() => {
    function freshBoard() {
      // Cria a borda do jogo com as informações da API do jogo feito em Prolog
      axios.get(`http://api/get-mine`)
        .then(res => {
          const newBoard = res.data;
          setGrid(newBoard);
        })
    }
    freshBoard();
  }, []);

  return (
    <div className="parent">
      {console.log(grid)}
      {grid.map(singlerow => {
        return (
          <div style={style}>
            {singlerow.map(singlecol => {
              return <div
                style={{
                  width: 30,
                  height: 30,
                  padding: '5px',
                  border: '3px solid red'
                }}
              >
                {JSON.stringify(singlecol.value)}
              </div>
            })}
          </div>
        )
      })}
    </div>
  )

}
export default Board; 
