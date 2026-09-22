const text = "Welcome to oben-jha's 1337 Portfolio...";
let index = 0;
const speed = 75;

function typeWriter() {
    if (index < text.length) {
        document.getElementById("typing-text").innerHTML += text.charAt(index);
        index++;
        setTimeout(typeWriter, speed);
    }
}

window.onload = () => {
    typeWriter();
};