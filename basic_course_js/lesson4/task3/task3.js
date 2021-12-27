// Необходимо создать функцию getDigitsOfNumber, которая принимает целое
// положительное число в диапазоне от 0 до 1000.
// Функция должна вернуть обычный объект с тремя свойствами:
// 1. units - содержит число, количество единиц в параметре функции.
// 2. dozens - содержит число, количество десятков в параметре функции.
// 3. hundreds - содержит число, количество сотен в параметре функции.
// Если функции было передано не целое положительное число, либо число в ином
// диапазоне, нежели задано в условии, функция должна вывести в консоль информацию
// об ошибке и вернуть пустой объект.
// Необходимо также прописать jsdoc для данной функции.
//
// Подсказка:
// У объекта console есть разные методы, мы часто используем console.log для того
// чтобы вывести в консоль какое-то значение, однако есть и другие методы, найдите
// в интернете какие методы существуют и используйте "правильный метод" в нужном
// месте. Обратите внимание что функция не должна выбрасывать ошибку, она должна
// только вывести в консоль информацию о том, что что-то пошло не так.
// Обратите внимание на слова "от 0 до 1000", это означает диапазон [0, 999], что
// можно прочитать как "от нуля до 999 включительно".
"use strict";

function getDigitsOfNumber(number) {
  if (!Number.isInteger(number)) {
    console.warn("Not integer");
    return {};
  }
  if (number < 0 || number > 999) {
    console.warn("Number is out of range [0, 999]");
  }
  const NUMBER_STR = `${ number }`;
  return {
    units: +NUMBER_STR[NUMBER_STR.length - 1],
    dozens: +NUMBER_STR[NUMBER_STR.length - 2] || 0,
    hundreds: +NUMBER_STR[NUMBER_STR.length - 3] || 0,
  };
}

console.log("a", getDigitsOfNumber("a"));
console.log("1001", getDigitsOfNumber(1001));
console.log("3", getDigitsOfNumber(3));
console.log("29", getDigitsOfNumber(29));
console.log("138", getDigitsOfNumber(138));