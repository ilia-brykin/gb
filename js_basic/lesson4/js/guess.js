makeMenu("guess");
makeFooter();

const ANSWER = parseInt(Math.random() * 100);
let tryCount = 0;
const MAX_TRY_COUNT = 3;

function readInt(){
  return +document.getElementById("userAnswer").value;
}

function write(text){
  document.getElementById("info").innerHTML = text;
}

function hide(id){
  document.getElementById(id).style.display = "none";
}

function guess(){
  tryCount++;

  const USER_ANSWER = readInt();
  if(USER_ANSWER === ANSWER){
    write("<b>Поздравляю, вы угадали!</b>");
    hide("button");
    hide("userAnswer");
  } else if (tryCount >= MAX_TRY_COUNT){
    write(`Вы проиграли<br>Правильный ответ: ${ ANSWER }`);
    hide("button");
    hide("userAnswer");
  } else if (USER_ANSWER > ANSWER){
    write("Вы ввели слишком большое число<br>Попробуйте еще раз. Введите число от 1 до 100");
  } else if (USER_ANSWER < ANSWER){
    write("Вы ввели слишком маленькое число<br>Попробуйте еще раз. Введите число от 1 до 100");
  }
}

function changeAnswer($event) { // Фильтруем все символы кроме цифр
  $event.value = $event.value.replace(/\D/g, ""); // Показывать только цифры
}
