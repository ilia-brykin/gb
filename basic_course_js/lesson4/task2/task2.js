// Необходимо данное задание выполнить в es5 стиле и в es6 стиле.
// Необходимо создать функцию-конструктор/класс для поста в социальной сети.
// Названия: `PostES5` для es5 стиля и `PostES6` для es6 стиля.
// Пост должен хранить:
// 1. Автора поста (имени достаточно).
// 2. Текст поста.
// 3. Дату и время последнего изменения поста.
// Данные автора поста и текст поста необходимо передавать при создании
// экземпляра объекта.
// Каждому экземпляру объекта должен быть доступен метод `edit`, который будет
// менять текст поста.
//
// ---
//
// Необходимо создать функцию-конструктор/класс для закрепленного поста в
// социальной сети.
// Названия: `AttachedPostES5` для es5 стиля и `AttachedPostES6` для es6 стиля.
// Закрепленный пост должен наследоваться от обычного поста.
// Данные автора поста и текст поста необходимо передавать при создании
// экземпляра объекта.
// Закрепленный пост должен иметь свойство `highlighted`, в котором по умолчанию
// будет лежать значение false (это свойство будет обозначать, будет ли наш
// закрепленный пост подсвечен).
// У экземпляров объекта закрепленного поста должен быть метод с названием
// `makeTextHighlighted`, который сделает так, чтобы наш пост стал подсвеченным
// (будет менять свойство `highlighted`).
//
// ---
//
// Подсказки:
// 1. Задание сложное, советую делать по аналогии с примером на онлайн-занятии.
// 2. Обратите внимание что пост хранит "дату и время последнего изменения
// поста", это значит что если пост кто-то изменит (например вызовет какой-то
// метод, который изменит что-то в посте), дата и время последнего изменения
// поста также должна измениться.
// 3. Выполняйте все по порядку, не стоит пытаться сделать все сразу, иначе можно
// что-нибудь пропустить.
// 4. Если непонятно условие - задайте вопрос.
"use strict";

function PostES5(name, text) {
  this.name = name;
  this.text = text;
  this.datetime = new Date();
}

PostES5.prototype.updateDatetime = function() {
  this.datetime = new Date();
}

PostES5.prototype.edit = function(text) {
  this.text = text;
  this.updateDatetime();
}

function AttachedPostES5(name, text) {
  PostES5.call(this, name, text);
  this.highlighted = false;
}

AttachedPostES5.prototype = Object.create(PostES5.prototype);
AttachedPostES5.prototype.constructor = AttachedPostES5;

AttachedPostES5.prototype.makeTextHighlighted = function() {
  this.highlighted = true;
  this.updateDatetime();
}

class PostES6 {
  constructor(name, text) {
    this.name = name;
    this.text = text;
    this.datetime = new Date();
  }

  edit(text) {
    this.text = text;
    this.updateDatetime();
  }

  updateDatetime() {
    this.datetime = new Date();
  }
}

class AttachedPostES6 extends PostES6 {
  constructor(name, text) {
    super(name, text);
    this.highlighted = false;
  }

  makeTextHighlighted() {
    this.highlighted = true;
    super.updateDatetime();
  }
}

const POST_1 = new AttachedPostES5("Autor 1", "Aloha1");
const POST_2 = new AttachedPostES6("Autor 2", "Aloha2");
POST_1.edit("Hola1");
POST_2.edit("Hola2");
POST_1.makeTextHighlighted();
POST_2.makeTextHighlighted();
console.log("POST_1", POST_1);
console.log("POST_2", POST_2);
