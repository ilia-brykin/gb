const TRAPEZE = { // Используем "const", если переменная не изменяется
  a: 0,
  b: 0,
  h: 0,
};
[ // Новый массив, потому что есть повторяющиеся действия
  {
    msg: "Введите пожалуйста длину первого основания трапеции",
    key: "a",
  },
  {
    msg: "Введите пожалуйста длину второго основания трапеции",
    key: "b",
  },
  {
    msg: "Введите пожалуйста высоту трапеции",
    key: "h",
  },
].forEach(item => { // перебираем все элементы массива
  let message = item.msg;
  let valueFromPrompt;
  while (true) {  // создаем бесконечный цикл
    valueFromPrompt = +prompt(message);
    if (isNaN(valueFromPrompt)) {  // если не число
      message = `Пожалуйста введите число. ${ item.msg }`;
    } else if (valueFromPrompt <= 0) {
      message = `Пожалуйста введите число большее нуля. ${ item.msg }`;
    } else {
      break;
    }
  }
  TRAPEZE[item.key] = valueFromPrompt;
});
const AREA_TRAPEZE = ((TRAPEZE.a + TRAPEZE.b) / 2) * TRAPEZE.h;
alert(`Площадь трапеции будет равна ${ AREA_TRAPEZE }`);
