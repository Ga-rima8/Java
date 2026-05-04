const deer = document.getElementById("deer");
const title = document.getElementById("title");

const letters = [
  document.getElementById("l-H"),
  document.getElementById("l-a1"),
  document.getElementById("l-n"),
  document.getElementById("l-g"),
  document.getElementById("l-A"),
  document.getElementById("l-u"),
  document.getElementById("l-r"),
  document.getElementById("l-a2"),
];

const totalDuration = 2000;

function scheduleHits() {
  const titleRect = title.getBoundingClientRect();
  const totalWidth = titleRect.width + 70;

  letters.forEach(el => {
    const rect = el.getBoundingClientRect();
    const centerX = rect.left - titleRect.left + rect.width / 2;
    const fraction = (centerX + 70) / (totalWidth + 70);
    const time = fraction * totalDuration;

    setTimeout(() => {
      el.classList.remove("jiggle");
      void el.offsetWidth;
      el.classList.add("jiggle");
    }, time);
  });
}

scheduleHits();

deer.addEventListener("animationend", () => {
  deer.classList.add("settled");
});