const PUZZLES = [ // Массив с загадками. Используем "const", потому что массив неизменен
  {
    question: "У него огромный рот, oн зовется …",
    answers: [  // Возможные ответы
      "бегемот",
      "носорог",
    ],
  },
  {
    question: "На что человек садится?",
    answers: [  // Возможные ответы
      "стул",
      "табуретка",
      "кресло",
    ],
  },
  {
    question: "Зимой и летом одним цветом",
    answers: [  // Возможные ответы
      "елка",
      "ёлка",
      "ель",
      "сосна",
    ],
  },
  {
    question: "Висит груша - нельзя скушать ",
    answers: [  // Возможные ответы
      "лампочка",
      "боксёрская груша",
      "боксерская груша",
    ],
  },
];
let countCorrectAnswers = 0;


PUZZLES.forEach(puzzle => { // перебор всех элементов массива, где "puzzle" - элемент массива
  const ANSWER = prompt(puzzle.question);
  const ANSWER_LOVER_CASE = ANSWER.toLowerCase(); // toLowerCase() Переводим все буквы к нижнему регистру
  if (puzzle.answers.indexOf(ANSWER_LOVER_CASE) !== -1) { // indexOf(ANSWER) Поиск индекса ответа в массиве возможных ответов. Если ответ не найден, то функция вернет -1
    // ответ найден
    alert(`Ваш ответ: "${ ANSWER }" верный. Поздравляем!!!`); // `text ${ variable }` Разновидность конкатенации
    countCorrectAnswers++;
  } else {
    // ответ не найден
    alert(`Ваш ответ: "${ ANSWER }". К сожалению, Вы не угадали.`);
  }
});

alert(`Количество правильных ответов: ${ countCorrectAnswers } из ${ PUZZLES.length }`); // PUZZLES.length Длина массива "PUZZLES" или количество загадок
