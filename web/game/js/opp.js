var opp_id = "0"; //TODO: remove this line

function getOpp() {
  console.log("getOpp Start with Opp_ID: " + opp_id);

  $.comPost("ajax/opp", {"opp_id" : String(opp_id)}, getOpp, function(data, status) {
    console.log("Opponent data !" + data.opp_id);
    if (data.error_code != 0) {
      console.log("BAD BAD BAD BAD BAD opp Return !");
      return;
    }
    opp_id = data.opp_id;
    handleOpponent(data.json);
    console.log("getOpp Return !");
    getOpp();
  });
}