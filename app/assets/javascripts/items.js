const stars = document.querySelector(".ratings").children;
const ratingValue = document.getElementById("rating-value")


let clean_index;


for(let i=0; i<stars.length; i++){
  stars[i].addEventListener("mouseover", function(){
    for(let j=0; j<stars.length; j++){
      stars[j].classList.remove("fa-star");
      stars[j].classList.add("fa-star-o");
    }
    for(let j=0; j<=i; j++){
      stars[j].classList.remove("fa-star-o");
      stars[j].classList.add("fa-star");
    }
  })

  stars[i].addEventListener("click", function(){
      ratingValue.value = i + 1;
      clean_index = i;
  })
  

  stars[i].addEventListener("mouseout", function(){
    for(let j=0; j<stars.length; j++){
      stars[j].classList.remove("fa-star");
      stars[j].classList.add("fa-star-o");
    }
    for(let j=0; j<=clean_index; j++){
      stars[j].classList.remove("fa-star-o");
      stars[j].classList.add("fa-star");
    }
  })
}


const heat = document.querySelector(".heatings").children;
const heatingValue = document.getElementById("heat-value")

let heat_index;


for(let i=0; i<heat.length; i++){
  heat[i].addEventListener("mouseover", function(){
    for(let j=0; j<heat.length; j++){
      heat[j].classList.remove("fa-circle");
      heat[j].classList.add("fa-circle-o");
    }
    for(let j=0; j<=i; j++){
      heat[j].classList.remove("fa-circle-o");
      heat[j].classList.add("fa-circle");
    }
  })

  heat[i].addEventListener("click", function(){
      heatingValue.value = i + 1;
      heat_index = i;
  })

  heat[i].addEventListener("mouseout", function(){
    for(let j=0; j<heat.length; j++){
      heat[j].classList.remove("fa-circle");
      heat[j].classList.add("fa-circle-o");
    }
    for(let j=0; j<=heat_index; j++){
      heat[j].classList.remove("fa-circle-o");
      heat[j].classList.add("fa-circle");
    }
  })
}




document.addEventListener("DOMContentLoaded", function() {
  var genreSelect = document.getElementById("genre_id_select");
  var heatIndexField = document.getElementById("heat_index");

  function toggleHeatIndexField() {
    heatIndexField.style.display = (genreSelect.value >= 2 && genreSelect.value <= 4) ? "block" : "none";
  }

  toggleHeatIndexField();
  genreSelect.addEventListener("change", toggleHeatIndexField);
});


document.addEventListener("DOMContentLoaded", function() {
  const input = document.getElementById("image-upload");
  const preview = document.getElementById("image-preview");

  input.addEventListener("change", function() {
    if (this.files && this.files[0]) {
      const reader = new FileReader();

      reader.onload = function(e) {
        preview.innerHTML = '<img src="' + e.target.result + '" alt="画像プレビュー">';
      };

      reader.readAsDataURL(this.files[0]);
    } else {
      preview.innerHTML = "";
    }
  });
});