var room_pass = "";
var room_pass_id = 0;

var current_tile = 0;

$(document).ready(function() {
  /* Initiate creating room */
  $("#tile_"+current_tile).addClass("map_active");

  $(".map_tile").click(function() {
    $("#tile_"+current_tile).removeClass("map_active");
    current_tile = $(this).attr("data-tile");
    $("#tile_"+current_tile).addClass("map_active");
  });

  $(".map_cell").click(function() {
    if (current_tile >= 100) {
      $(".tile_"+current_tile).html("");
      $(".tile_"+current_tile).attr("data-tile2", 0);
      $(".tile_"+current_tile).removeClass("tile_"+current_tile);
      $(this).attr("data-tile2", current_tile);
      $(this).addClass("tile_"+current_tile);
      if (current_tile == 100) {
        $(this).html("<span class='tile_letter red'>K</span>");
      }
      if (current_tile == 101) {
        $(this).html("<span class='tile_letter red'>C</span>");
      }
      if (current_tile == 102) {
        $(this).html("<span class='tile_letter blue'>K</span>");
      }
      if (current_tile == 103) {
        $(this).html("<span class='tile_letter blue'>C</span>");
      }
      return;
    }
    $(this).css("background-color", "#"+getColour());
    $(this).attr("data-tile", current_tile);
  });

});

function getColour() {
  return TILES[current_tile][1];
}