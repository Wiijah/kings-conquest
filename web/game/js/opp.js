var opp_id = 0; //TODO: remove this line

$(document).ready(function() {
  getOpp();


});

function getOpp() {
  comPost("ajax/opp", {"opp_id" : opp_id}, function(data) {
    console.log("Opponent data !" + data + opp_id + data.error_code);
    if (data.error_code != 0) {
      return;
    }
    opp_id = data.opp_id;
    // handleOpp(data.json);
    getOpp();
  });
}