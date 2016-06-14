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

  $("#save_map").click(saveMap);

  $(".map_cell").click(function() {
    if (current_tile >= 100) {
      if ($(this).attr("data-tile") == 5) {
        lightbox_alert("Error", "You cannot place your king or castle on water.");
        return;
      }
      if ($(this).attr("data-tile2") == current_tile) return;
      if ($(this).attr("data-tile2") != 0) {
        lightbox_alert("Error", "You cannot have two units or buildings on the same tile.");
        return;
      }
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


$(document).ready(function() {
  $("#lightbox_btn_new_map").click(function() {
    var map_name = $("#map_name").val();

    /* Client slide input check */
    if (!isStrLenCorrect(map_name, 3, 20)) {
      lightbox_error("The map name must be between 3 to 20 characters.");
      return;
    }
    quickPost("ajax/map_new", {map_name: map_name}, function(data, status){
      if (session_expired) return;

      // server side error checking
      if (data.kc_error !== undefined) {
        lightbox_error(data.kc_error);
        return;
      }

      window.location.href = 'map_editor?map_id='+data.map_id;
    });
  });
});

function getColour() {
  return TILES[current_tile][1];
}

function generateMapJSON() {
  var out = "{";
  var comma;
  var outer_comma = "";
  for (var y = 0; y < 13; y++) {
    out += outer_comma+'"'+y+'": [';
    comma = "";
    for (var x = 0; x < 13; x++) {
      out += comma+$("#tile_"+x+"_"+y).attr("data-tile");
      comma = ",";
    }
    out += "]";
    outer_comma = ",";
  }
  out += "}";
  return out;
}

function saveMap() {
  var contains_blue_king = false;
  var contains_blue_castle = false;

  var contains_red_king = false;
  var contains_red_castle = false;

  var red_king_x = 0;
  var red_king_y = 0;
  var red_castle_x = 0;
  var red_castle_y = 0;

  var blue_king_x = 0;
  var blue_king_y = 0;
  var blue_castle_x = 0;
  var blue_castle_y = 0;

  for (var y = 0; y < 13; y++) {
    for (var x = 0; x < 13; x++) {
      var tile = $("#tile_"+x+"_"+y).attr("data-tile2");
      if (tile == 100) {
        contains_red_king = true;
        red_king_x = x;
        red_king_y = y;
      }
      if (tile == 101) {
        contains_red_castle = true;
        red_castle_x = x;
        red_castle_y = y;
      }
      if (tile == 102) {
        contains_blue_king = true;
        blue_king_x = x;
        blue_king_y = y;
      }
      if (tile == 103) {
        contains_blue_castle = true;
        blue_castle_x = x;
        blue_castle_y = y;
      }
    }
  }

  if (!contains_red_king) {
    lightbox_alert("Error", "Your map must contain one red king before you can save it.");
    return;
  }
  if (!contains_red_castle) {
    lightbox_alert("Error", "Your map must contain one red castle before you can save it.");
    return;
  }
  if (!contains_blue_king) {
    lightbox_alert("Error", "Your map must contain one blue king before you can save it.");
    return;
  }
  if (!contains_blue_castle) {
    lightbox_alert("Error", "Your map must contain one blue castle before you can save it.");
    return;
  }

  var json = generateMapJSON();
  var map_name = $("#form_map_name").val();

  var red_king_loc = "["+red_king_x+", "+red_king_y+"]";
  var red_castle_loc = "["+red_castle_x+", "+red_castle_y+"]";
  var blue_king_loc = "["+blue_king_x+", "+blue_king_y+"]";
  var blue_castle_loc = "["+blue_castle_x+", "+blue_castle_y+"]";

  quickPost("ajax/map_save", {"map_id": map_id, "map_name": map_name, "points": json, "red_king" : red_king_loc, "red_castle" : red_castle_loc, "blue_king" : blue_king_loc, "blue_castle" : blue_castle_loc}, function(data, status){
    if (session_expired) return;

    // server side error checking
    if (data.kc_error !== undefined) {
      lightbox_alert("Error", data.kc_error);
      return;
    }

    lightbox_alert("Map Saved", "Your map was successfully saved.");
  });
}