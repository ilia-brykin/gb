// Необходимо данное задание выполнить в es5 стиле и в es6 стиле.
// Необходимо создать функцию-конструктор/класс для продукта.
// Названия: `ProductES5` для es5 стиля, `ProductES6` для es6 стиля.
// При создании объекта от функции-конструктора/класса необходимо передавать имя
// и цену товара, эта информация должна быть сохранена в объекте.
// Также у объекта должна быть возможность выполнить метод `make25Discount`, данный
// метод должен уменьшать стоимость продукта на 25%.
// Необходимо продемонстрировать работу с объектом (в свободной форме).
"use strict";

function ProductES5(name, price) {
  this.name = name;
  this.price = price;
}

ProductES5.prototype.make25Discount = function() {
  this.price *= 0.75;
};

class ProductES6 {
  constructor(name, price) {
    this.name = name;
    this.price = price;
  }

  make25Discount() {
    this.price *= 0.75;
  }
}

const PRODUCT_1 = new ProductES5("product1", 100);
const PRODUCT_2 = new ProductES6("product2", 100);
PRODUCT_1.make25Discount();
PRODUCT_2.make25Discount();
console.log("PRODUCT_1", PRODUCT_1.name, PRODUCT_1.price);
console.log("PRODUCT_2", PRODUCT_2.name, PRODUCT_2.price);
