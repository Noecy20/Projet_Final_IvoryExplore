// alert("Test")
const allImages = document.querySelectorAll(".images .img");
const lightbox = document.querySelector(".lightbox");
const closeImgBtn = lightbox.querySelector("#close-icon");
console.log(closeImgBtn);
allImages.forEach((img) => {
  // Calling showLightBox function with passing clicked img src as argument
  img.addEventListener("click", () =>
    showLightbox(img.querySelector("img").src)
  );
});
const showLightbox = (img) => {
  // Showing lightbox and updating img source
  lightbox.querySelector("img").src = img;
  lightbox.classList.add("show");
  document.body.style.overflow = "hidden";
};
closeImgBtn.addEventListener("click", () => {
  // Hiding lightbox on close icon click
  lightbox.classList.remove("show");
  document.body.style.overflow = "auto";
});

// const filterButton = document.querySelector("#filtre");
// filterButton.addEventListener("click", () => {
//   const filteredContent = document.querySelector("#contenue-filtrer");
//   filteredContent.style.display =
//     filteredContent.style.display === "none" ? "block" : "none";
// });

const rangeInput = document.querySelectorAll(".range-input input"),
  priceInput = document.querySelectorAll(".price-input input"),
  range = document.querySelector(".slider .progress");
let priceGap = 1000;

priceInput.forEach((input) => {
  input.addEventListener("input", (e) => {
    let minPrice = parseInt(priceInput[0].value),
      maxPrice = parseInt(priceInput[1].value);

    if (maxPrice - minPrice >= priceGap && maxPrice <= rangeInput[1].max) {
      if (e.target.className === "input-min") {
        rangeInput[0].value = minPrice;
        range.style.left = (minPrice / rangeInput[0].max) * 100 + "%";
      } else {
        rangeInput[1].value = maxPrice;
        range.style.right = 100 - (maxPrice / rangeInput[1].max) * 100 + "%";
      }
    }
  });
});

rangeInput.forEach((input) => {
  input.addEventListener("input", (e) => {
    let minVal = parseInt(rangeInput[0].value),
      maxVal = parseInt(rangeInput[1].value);

    if (maxVal - minVal < priceGap) {
      if (e.target.className === "range-min") {
        rangeInput[0].value = maxVal - priceGap;
      } else {
        rangeInput[1].value = minVal + priceGap;
      }
    } else {
      priceInput[0].value = minVal;
      priceInput[1].value = maxVal;
      range.style.left = (minVal / rangeInput[0].max) * 100 + "%";
      range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
    }
  });
});

// Hugues Codeur JS Restaurant Test
// alert("Hugues Codeur")
const contenueFiltre = document.querySelector(".contenue-filtre");
const filterH4 = document.querySelector(".filter-h4");
const filtreButton = document.getElementById("filtre");
const resto = document.querySelector(".resto");
const divCardFilter = document.querySelector(".div-card-filter");
const wrapperResto = document.querySelector(".wrapper_resto");
console.log(contenueFiltre);
console.log(divCardFilter);
// console.log(filterButton);
// console.log(resto);

// const filterButton = document.querySelector("#filtre");
filtreButton.addEventListener("click", () => {
  divCardFilter.classList.toggle("div-card-filter_visible");
  contenueFiltre.classList.toggle("contenue-filtre_visible");
  resto.classList.toggle("resto_width_visible");
  //   const filteredContent = document.querySelector("contenue-filtre_visible");
  //   filteredContent.style.display =
  //     filteredContent.style.display === "none" ? "block" : "none";
});

// filterContent.addEventListener("click", () => {
//   console.log("red");
//   filterH4.style.color = "blue";

//     filterContent.style.visibily = "hidden";
// });


 setInterval(() => {
   const time = document.querySelector(".display #time");
   let date = new Date();
   let hours = date.getHours();
   let minutes = date.getMinutes();
   let seconds = date.getSeconds();
   let day_night = "AM";
   if (hours > 12) {
     day_night = "PM";
     hours = hours - 12;
   }
   if (seconds < 10) {
     seconds = "0" + seconds;
   }
   if (minutes < 10) {
     minutes = "0" + minutes;
   }
   if (hours < 10) {
     hours = "0" + hours;
   }
   time.textContent = hours + ":" + minutes + ":" + seconds + " " + day_night;
 });

 