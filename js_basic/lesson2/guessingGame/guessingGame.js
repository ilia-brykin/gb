const NAME_GAMER_FIRST = prompt("Введите имя первого игрока.");
const NAME_GAMER_SECOND = prompt("Введите имя второго игрока.");
let statusFirstGamer = true; // Переменная типа Boolean, которая укажет на то какой игрок ходит

const ANSWER = parseInt(Math.random() * 10);
let userAnswer;
while (true) { // Создаем бесконечный цикл
  // `text ${ variable }` Разновидность конкатенации
  userAnswer = prompt(`Угадайте число от 0 до 100 или введите exit для выхода.\nХод ${ statusFirstGamer ? "первого" : "второго" } игрока: "${ statusFirstGamer ? NAME_GAMER_FIRST : NAME_GAMER_SECOND }"`);
  if (userAnswer === "exit") {
    alert("Вы вышли из игры");
    break; // Выход из цикла
  }
  if (+userAnswer === ANSWER) {
    alert(`${ statusFirstGamer ? "Первый" : "Второй" } игрок: "${ statusFirstGamer ? NAME_GAMER_FIRST : NAME_GAMER_SECOND }" угадал число: ${ ANSWER }`);
    break; // Выход из цикла
  }
  statusFirstGamer = !statusFirstGamer; // смена хода
}
