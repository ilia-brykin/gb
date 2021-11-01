makeMenu("puzzle");
makeFooter();

let countCorrectAnswers = 0;
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

makeQuestions();

function makeQuestions() {
  let questionsHtml = "";
  PUZZLES.forEach((puzzle, index) => { // перебор всех элементов массива, где "puzzle" - элемент массива
    questionsHtml += `<p>${ puzzle.question }</p><input type="text" id="userAnswer${ index }">`;
  });
  const BOX_ELEMENT = document.querySelector(".box");
  BOX_ELEMENT.insertAdjacentHTML("afterbegin", questionsHtml);
}

function checkAnswers() {
  PUZZLES.forEach((puzzle, index) => { // перебор всех элементов массива, где "puzzle" - элемент массива
    checkAnswer(puzzle.answers, index);
  });

  alert(`Вы отгадали ${ countCorrectAnswers } загадок`);
  countCorrectAnswers = 0;
}

function checkAnswer(answers, index){
  const ID = `userAnswer${ index }`;
  let userAnswer = document.getElementById(ID).value;
  userAnswer = userAnswer.toLowerCase();
  if (answers.indexOf(userAnswer) !== -1) {
    countCorrectAnswers++;
  }
}
