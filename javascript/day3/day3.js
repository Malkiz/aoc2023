const fs = require('fs');
const path = require('path');

const input = fs.readFileSync(path.resolve(__dirname, 'input.txt'), 'utf8');

const lines = input.split('\n');

const numbers = [];
const symbols = [];

lines.forEach((line, row) => {
  let col = 0;
  while (col < line.length) {
    const number = line.slice(col).match(/\d+/);
    if (number) {
      // console.log(number);
      numbers.push({
        number: parseInt(number[0]),
        row,
        col: col + number.index,
        colEnd: col + number.index + number[0].length,
      });
      col = col + number.index + number[0].length;
    } else {
      col = line.length;
    }
  }

  col = 0;
  while (col < line.length) {
    const symbol = line.slice(col).match(/[^0-9.]/);
    if (symbol) {
      // console.log(symbol);
      symbols.push({
        symbol: symbol[0],
        row,
        col: col + symbol.index,
      });
      col = col + symbol.index + symbol[0].length;
    } else {
      col = line.length;
    }
  }
});

function isNumberAdjacentToSymbol(row, col, colEnd) {
  const symbol = symbols.find((s) => {
    const minCol = s.col - 1;
    const maxCol = s.col + 1;
    const minRow = s.row - 1;
    const maxRow = s.row + 1;
    return (row >= minRow && row <= maxRow && ((col >= minCol && col <= maxCol) || (colEnd >= minCol && colEnd <= maxCol)));
  });
  if (symbol) {
    return true;
  }
  return false;
}

let sum = 0;
numbers.forEach((number) => {
  if (isNumberAdjacentToSymbol(number.row, number.col, number.colEnd)) {
    // console.log(number);
    sum += number.number;
  }
});

console.log(sum);
