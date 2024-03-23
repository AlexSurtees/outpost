import { Chessground } from './chessground.ts'
import { Chess } from 'chess.js'


$.get('/dashboard/fen', function(data) {
    const fens = JSON.parse(data.response)
    let currentMove = 0;

    const config = {
        'viewOnly': true
    };
    const ground = Chessground(document.getElementById('chess-board'), config);

    const nextButton = document.getElementById('nextMove')
    const previousButton = document.getElementById('previousMove')

    nextButton.addEventListener('click', function() {
        currentMove++
        ground.set({'fen': fens[currentMove]})
    })    

    previousButton.addEventListener('click', function() {
        currentMove--
        ground.set({'fen': fens[currentMove]})
    })    


})


