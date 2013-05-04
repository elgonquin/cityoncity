$(document).ready(function() {

var url = "https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&alt=json&searchType=image&imgSize=large&q=london"

$.getJSON(url, searchResult); /* makes the call to Google API & calls searchResult with the response as an argument (data */

var results = []; /*array to store the results in */
var runs=0; /*variable to store the number of images it has rendered */

function searchResult(data) {
  
  for (i=0; i<data.items.length; i++) {  /*for each item in the data, get the link and add it to the results array */
    results.push(data.items[i].link); 
    results.reverse(); /* reverse the array so it has the 10th result in position 0 etc. */
  };

  for (i = 0; i < results.length; i++) {
    (function (i, result) {
      var timer = i * 500;
      setTimeout(function () {
        $('#images').append('<div class="imagebox"><span><img class="layer" id="image' + i + '" src="' + results[i] + '"/></span></div>');
      }, timer);
    })(i, results[i]);
    
  }
};
});


/*https://www.googleapis.com/customsearch/v1?key=AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU&cx=013540816258995479397:wtodrf8plwa&q=london&alt=json&searchType=image&imgSize=large

API Key: AIzaSyDiALif9o9MJdPUXpas_WGSO-9-cz_a4zU
CSE ID: 013540816258995479397:wtodrf8plwa
*/