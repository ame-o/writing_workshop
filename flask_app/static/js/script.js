// https://api.dictionaryapi.dev/api/v2/entries/en/<word>
console.log("hello hello...");


// --------------------------------------------------------------
// slides
// --------------------------------------------------------------
let slideIndex = [1, 1];
let slideId = ["mySlides1", "mySlides2"]
showSlides(1, 0);
showSlides(1, 1);

function plusSlides(n, no) {
    showSlides(slideIndex[no] += n, no);
}

function showSlides(n, no) {
    let i;
    let x = document.getElementsByClassName(slideId[no]);
    if (n > x.length) { slideIndex[no] = 1 }
    if (n < 1) { slideIndex[no] = x.length }
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
    }
}
// --------------------------------------------------------------
// one word
// --------------------------------------------------------------

var card = document.querySelector('.card');
card.addEventListener('click', function () {
    card.classList.toggle('is-flipped');
});

async function call_word() {
    var spelling = document.getElementById("spelling")
    console.log(spelling.innerText);
    var response = await fetch(`https://api.dictionaryapi.dev/api/v2/entries/en/${spelling.innerText}`);
    var word = await response.json();
    console.log(word);
    link = word[0].phonetics[0].audio
    pronounciation = document.getElementById("pronounciation")
    pronounciation.src = link
    // return link
}
call_word();
