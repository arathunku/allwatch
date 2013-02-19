$(document).ready(function() {
  $(".auction").click(function(){
    var id = $(this).attr('id');
    $(".sidebar").empty().html("<iframe style='height: 90%' src='http://m.allegro.pl/item/index/id/"+ id +"'></iframe>");
  });
});