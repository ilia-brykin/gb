function makeMenu(key) {
  let menuHtml = "";
  [
    {
      path: "index.html",
      text: "Главная",
    },
    {
      path: "puzzle.html",
      text: "Загадки",
    },
    {
      path: "guess.html",
      text: "Угадайка",
    },
    {
      path: "guessForTwoPeople.html",
      text: "Угадайка для двух игроков",
    },
    {
      path: "passwordGenerator.html",
      text: "Генератор случайных паролей",
    },
  ].forEach(item => {
    let {
      path
    } = item;
    if (path === `${ key }.html`) {
      path = "#";
    }
    menuHtml += `<a href="${ path }">${ item.text }</a>`;
  });
  menuHtml = `<header class="header">${ menuHtml }</header>`;
  const CONTENT_ELEMENT = document.querySelector(".content");
  CONTENT_ELEMENT.insertAdjacentHTML("afterbegin", menuHtml);
}

function makeFooter() {
  const FOOTER = `<footer class="footer">Copyright ${ new Date().getFullYear() }&copy; Ilia Brykin</footer>`;
  document.body.insertAdjacentHTML("beforeend", FOOTER);
}
