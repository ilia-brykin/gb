// Необходимо попросить пользователя ввести два числа в переменные `a` и `b`.
// Необходимо вывести в консоль один результат из следующих проверок:
// 1. Если оба числа в переменных `a` и `b` положительные, вывести разность
// чисел `a` и `b`, а именно, вычесть из переменной `a` значение переменной `b`.
// 2. Если оба числа в переменных `a` и `b` отрицательные, вывести произведение
// чисел `a` и `b`.
// 3. Если числа в переменных `a` и `b` разных знаков, вывести сумму чисел
// `a` и `b`.
// В остальных случаях программа не должна ничего выводить.
"use strict";
function onInput() {
  setText();
}

function setText() {
  const a = +document.getElementById("inputA").value;
  const b = +document.getElementById("inputB").value;
  let result = "";
  if (a > 0 && b > 0) {
    result = a - b;
  } else if (a < 0 && b < 0) {
    result = a * b;
  } else if ((a < 0 && b > 0) || (a > 0 && b < 0)) {
    result = a + b;
  }
  document.getElementById("text").innerText = result;
}
