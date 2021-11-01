const DOLLAR_IN_RUBLES = 70; // Используем "const", если переменная не изменяется
const EURO_IN_RUBLES = 90;
const MESSAGE_IN_PROMPT_DEFAULT = "Сколько рублей Вы хотите конвертировать?";
let messageInPrompt = MESSAGE_IN_PROMPT_DEFAULT; // Используем "let", если переменная изменяется. современный аналог "var"
let countRubles;
while (true) { // создаем бесконечный цикл
  countRubles = +prompt(messageInPrompt);
  if (isNaN(countRubles)) { // если не число
    messageInPrompt = `Пожалуйста введите число. ${ MESSAGE_IN_PROMPT_DEFAULT }`; // `text ${ variable }` Разновидность конкатенации
  } else if (countRubles <= 0) {
    messageInPrompt = `Пожалуйста введите число большее нуля. ${ MESSAGE_IN_PROMPT_DEFAULT }`;
  } else {
    break;
  }
}
const COUNT_DOLLAR = countRubles / DOLLAR_IN_RUBLES;
const COUNT_EURO = countRubles / EURO_IN_RUBLES;
alert(`${ countRubles } рублей это ${ COUNT_DOLLAR } доллар${ COUNT_DOLLAR === 1 ? "" : "ов" } по курсу 1:${ DOLLAR_IN_RUBLES }. 
  ${ countRubles } рублей это ${ COUNT_EURO } евро по курсу 1:${ EURO_IN_RUBLES }.
`);

// COUNT_DOLLAR === 1 ? "" : "ов" если COUNT_DOLLAR не равно 1, то добавить "ов"
