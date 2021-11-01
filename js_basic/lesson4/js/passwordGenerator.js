makeMenu("passwordGenerator");
makeFooter();

function changeAnswer($event) { // Фильтруем все символы кроме цифр
  $event.value = $event.value.replace(/\D/g, ""); // Показывать только цифры
}

function generate() {
  const USER_ANSWER = readInt();
  let passwd = "";
  let chars = "abcdefghijklmnopqrstuvwxyz";
  chars += chars.toUpperCase();
  chars += "0123456789";
  for (let i = 1; i <= USER_ANSWER; i++) {
    const INDEX = parseInt(Math.random() * chars.length);
    passwd += chars[INDEX];
  }
  const PASSWORT_ELEMENT = document.getElementById("password");
  PASSWORT_ELEMENT.innerHTML = `<p>Ваш новый пароль: <strong>${ passwd }</strong></p>`;
}

function readInt(){
  return +document.getElementById("userAnswer").value;
}
