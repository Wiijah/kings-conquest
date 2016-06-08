function getOpp() {
//  console.log("getOpp start of body with oldOPPID: " + lastOppID);

  comPost("ajax/opp", {"opp_id" : String(lastOppID)}, nothing, function(data, status) {
    //console.log("Inside comPost callback with OppID: !" + data.opp_id);
    if (data.error_code != 0) {
      //console.log("BAD BAD BAD BAD BAD opp Return !");
      return;
    }
    lastOppID = data.opp_id;
    handleOpponent(data.json);
    //console.log("callback returned!");
    getOpp();
  });
  //console.log("Real getOpp out");
}

function quit_game() {
  rawPost("ajax/leave_game", {}, function(data) {
    window.location.href = '../interface/game_stats?room_id='+room_id;
}