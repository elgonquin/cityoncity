$(document).ready(function() {

var str=location.href.toLowerCase();

console.log(str);

$("li a").each(function() {
  if (str.indexOf(this.href.toLowerCase()) > -1) {
    $("li.highlight").removeClass("highlight");
    $(this).addClass("highlight");
    }
 });

});
