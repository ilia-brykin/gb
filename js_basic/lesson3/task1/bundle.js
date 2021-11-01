const NUMBERS = [ // Используем "const" если переменная не переопределяется в коде
  1,
  10,
  56,
  67,
  78,
  34,
  456,
  77,
];
document.write("a. Написать функцию, которая принимает в качестве параметра число n. Результатом работы функции является массив из N элементов со значениями 1, 2, 3… n.<br>");
document.write(`${ createArrayFromLength(10) }<br>`);
document.write("b. Написать функцию, которая принимает массив чисел. Результатом работы функции является сумма чисел этого массива.<br>");
document.write(`${ sumAllElementsInArray(NUMBERS) }<br>`);
document.write("c. Написать функцию, которая на вход получает массив целых чисел, и в качестве результата возвращает максимальное число.<br>");
document.write(`${ findMaxInArray(NUMBERS) }<br>`);
document.write("d. Написать функцию, которая на вход получает массив целых чисел, и в качестве результата возвращает минимальное число.<br>");
document.write(`${ findMinInArray(NUMBERS) }<br>`);
document.write("f. Написать функцию, которая на вход получает массив целых чисел, и в качестве результата возвращает только четные числа из этого массива. Чтобы определить четность числа, воспользуйтесь оператором для подсчета остатка от деления: x % 2. Если остаток от деления числа на 2 равен 0, число будет четное.<br>");
document.write(`${ findAllEvenNumbersInArray(NUMBERS) }<br>`);


function createArrayFromLength(length) {
  const LIST = []; // Используем "const" если переменная не переопределяется в коде
  for (let i = 1; i <= length; i++) {
    LIST.push(i);
  }
  return LIST;
}

function sumAllElementsInArray(list) {
  let sum = 0; // Аналог "var" с ограниченной областью видимости
  list.forEach(item => { // перебор всех элементов массива
    sum += item;
  });
  return sum;
}

function findMaxInArray(list) {
  return Math.max(...list); // "..." - это Spread syntax. https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/Spread_syntax
}

function findMinInArray(list) {
  return Math.min(...list); // "..." - это Spread syntax. https://developer.mozilla.org/ru/docs/Web/JavaScript/Reference/Operators/Spread_syntax
}

function findAllEvenNumbersInArray(list) {
  const EVEN_NUMBERS = []; // Используем "const" если переменная не переопределяется в коде
  list.forEach(item => { // перебор всех элементов массива
    if (item % 2 === 0) {
      EVEN_NUMBERS.push(item);
    }
  });
  return EVEN_NUMBERS;
}
