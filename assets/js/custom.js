function hideTextTitle() {
  const title = document.getElementById("text-title");
  title.style.display = "none";
}

function showFlamingTitle() {
  const title = document.getElementById("flaming-title");
  title.style.display = "block";
}

if (Math.random() < 0.1) {
  hideTextTitle();
  showFlamingTitle();
}
