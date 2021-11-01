let sum = 0;
let percent = 0;
do {
  sum = +prompt("Введите пожалуйста сумму вклада.\nСумма должна быть положительным числом.");
} while (isNaN(sum) || sum < 0)

do {
  percent = +prompt("Введите пожалуйста ежегодный процент по вкладу.\nПроцент должен быть положительным числом.");
} while (isNaN(percent) || percent < 0)

document.write(`Сумма вклада: <strong>${ sum.toFixed(2) }</strong> под ${ percent.toFixed(2) } процентов в год<br>`); // `text ${ variable }` Разновидность конкатенации
percent /= 100; // Перевод числа в проценты, дели на 100
for (let i = 1; i <= 5; i++) {
  sum += sum * percent;
  document.write(`${ i } год. Размер вклада: <strong>${ sum.toFixed(2) }</strong> <br>`);
}
