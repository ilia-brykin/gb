// Создаем массив с тремя уровнями. Каждый уровень является объектом
const LEVELS = [ // Используем "const" если переменная не переопределяется в коде
  {
    message: "Положите четыре пальца левой руки - мизинец, безымянный, средний и указательный - на клавиши ф, ы, в, а. Запомните, что А находится под вашим указательным пальцем, а - Ф под мизинцем.\nТеперь неспеша набирайте текст. Постарайтесь не смотреть на клавиатуру.",
    letters: ["ф", "а"],
    taskLength: 10,
  },
  {
    message: "Поставьте мизинец левой руки на букву Ф, безымянный палец — на Ы, средний — на В, указательный — на А. Мизинец правой руки на букву Ж, безымянный палец — на Д, средний — на Л, указательный — на О.\nЗапомните расположение пальцев. Повторяйте за мной",
    letters: ["ы", "в"],
    taskLength: 10,
  },
  {
    message: "Поставьте мизинец левой руки на букву Ф, безымянный палец — на Ы, средний — на В, указательный — на А. Мизинец правой руки на букву Ж, безымянный палец — на Д, средний -— на Л, указательный — на О.\nЗапомните расположение пальцев. Повторяйте за мной",
    letters: ["о", "ж"],
    taskLength: 10,
  },
];

alert("Вас приветствует программа для обучения слепой печати");
LEVELS.forEach((level, levelIndex) => { // перебор всех элементов массива, где "level" - элемент массива, "levelIndex" - индекс в массиве (0, 1 ...)
  startLevel(level, levelIndex + 1);
});
alert("Поздравляем вы прошли все уровни!");


function startLevel(level, levelNumber) {
  alert(`Вы начинаете уровень номер ${ levelNumber }`); // `text ${ variable }` Разновидность конкатенации
  while (true) {
    alert(level.message);
    const TEXT = generateText(level.letters, level.taskLength);
    const USER_TEXT = prompt(TEXT);
    if (USER_TEXT === TEXT) {
      alert(`Все верно! Уровень номер ${ levelNumber } завершен`);
      break;
    } else {
      alert("Вы ошиблись. Попробуйте еще раз.");
    }
  }
}

function generateText(letters, length) {
  let text = "";
  for (let i = 0; i < length; i++) {
    const RANDOM_NUMBER = getRandomNumber(letters.length -1);
    text += letters[RANDOM_NUMBER];
  }
  return text;
}

function getRandomNumber(max) {
  return Math.round(Math.random() * max);
}
