var opp_id = 0; //TODO: remove this line

$(document).ready(function() {
  getOpp();


});

function getOpp() {
  console.log("getOpp Start !");
  comPost("ajax/opp", {"opp_id" : String(opp_id)}, function(data) {
    console.log("Opponent data !" + data.opp_id);
    if (data.error_code != 0) {
      console.log("bad opp Return !");
      return;
    }
    opp_id = data.opp_id;
    handleOpponent(data.json);
    console.log("getOpp Return !");
    getOpp();
  });
}