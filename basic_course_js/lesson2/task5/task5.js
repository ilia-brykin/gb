// Необходимо скопировать и вставить в данный скрипт все функции из 4 задания.
// Необходимо реализовать функцию:
// mathOperation(arg1, arg2, operation);
// Параметры:
// arg1 - первое число.
// arg2 - второе число.
// operation - строка, которая содержит один символ из: "+", "-", "*", "/".
// Функция mathOperation должна вернуть результат операции, который был передан в
// параметр operation для двух первых аргументов (arg1 и arg2).
// Функция mathOperation должна использовать для вычисления функции из 4 задания.
//
// Примеры вызова функции:
// console.log(mathOperation(5, 3, "+")); // 8
// console.log(mathOperation(5, 3, ":)")); // NaN
//
// Функции mathOperation всегда передаются корректные числа, проверки на NaN,
// Infinity делать не нужно, однако, в случае если был передан некорректный
// аргумент в параметр operation, необходимо вернуть NaN.
"use strict";

function mathOperation(arg1, arg2, operation) {
  if (operation === "+") {
    return sum(arg1, arg2);
  }
  if (operation === "-") {
    return diff(arg1, arg1);
  }
  if (operation === "*") {
    return multi(arg1, arg2);
  }
  if (operation === "/") {
    return div(arg1, arg2);
  }
  return NaN;
}

console.log(mathOperation(5, 3, "+"));
console.log(mathOperation(5, 3, ":)"));
