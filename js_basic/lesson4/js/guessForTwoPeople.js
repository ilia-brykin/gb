makeMenu("guessForTwoPeople");
makeFooter();

let namePlayerFirst = "";
let namePlayerSecond = "";
let statusFirstGamer = true; // Переменная типа Boolean, которая укажет на то какой игрок ходит
const ANSWER = parseInt(Math.random() * 100);

function start() {
  namePlayerFirst = document.getElementById("userName1").value;
  namePlayerSecond = document.getElementById("userName2").value;
  document.getElementById("players").style.display = "none";
  document.getElementById("game").style.display = "block";
  changePlayerInfo();
}

function changePlayerInfo() {
  const ELEMENT = document.getElementById("player_info");
  ELEMENT.textContent = getPlayerCurrentName();
}

function getPlayerCurrentName() {
  return statusFirstGamer ?
    `1: ${ namePlayerFirst }` :
    `2: ${ namePlayerSecond }`;
}

function guess() {
  const USER_ANSWER = readInt();
  if(USER_ANSWER === ANSWER){
    write(`<strong>Поздравляю, вы угадали!</strong> Игрок ${ getPlayerCurrentName() } победил`);
    hide("button2");
    hide("userAnswer");
    hide("info_box");
  } else if (USER_ANSWER > ANSWER){
    write("Вы ввели слишком большое число<br>Попробуйте еще раз. Введите число от 1 до 100");
    changePlayer();
  } else if (USER_ANSWER < ANSWER){
    write("Вы ввели слишком маленькое число<br>Попробуйте еще раз. Введите число от 1 до 100");
    changePlayer();
  }
}

function readInt(){
  return +document.getElementById("userAnswer").value;
}

function write(text){
  document.getElementById("info").innerHTML = text;
}

function hide(id){
  document.getElementById(id).style.display = "none";
}

function changePlayer() {
  statusFirstGamer = !statusFirstGamer;
  changePlayerInfo();
  document.getElementById("userAnswer").value = "";
}

function changeAnswer($event) { // Фильтруем все символы кроме цифр
  $event.value = $event.value.replace(/\D/g, ""); // Показывать только цифры
}
