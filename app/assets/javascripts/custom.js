$(document).ready(function() {
  $(".auction").click(function(){
    var id = $(this).attr('id');
    $(".sidebar").empty().html("<iframe style='height: 100%' src='http://m.allegro.pl/item/index/id/"+ id +"'></iframe>");
  });
});