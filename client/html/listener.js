var selected = "";

$(function()
{
    window.addEventListener('message', function(event)
    {
      if (event.data.KOTHUI == true) {
        document.getElementById("KOTHUI").style.display = "block";
      } else if (event.data.KOTHUI == false) {
        document.getElementById("KOTHUI").style.display = "none";
      }
      if (event.data.StartUI == true) {
        document.getElementById("Welcome").style.display = "block";
      } else if (event.data.StartUI == false) {
        document.getElementById("Welcome").style.display = "none";
      }
      if (event.data.ChangeModel == true) {
        document.getElementById("ModelSelect").style.display = "block";
      } else if (event.data.ChangeModel == false) {
        document.getElementById("ModelSelect").style.display = "none";
      }
      if (event.data.ChooseTeam == true) {
        document.getElementById("ChooseTeam").style.display = "block";
      } else if (event.data.ChooseTeam == false) {
        document.getElementById("ChooseTeam").style.display = "none";
      }
      if (event.data.LockTeam == true) {
        var lock = event.data.TeamToLock;
        document.getElementById(lock).disabled = "true";
      }
      if (event.data.UnlockTeam == true) {
        var unlock = event.data.TeamToUnlock;
        document.getElementById(unlock).disabled = "";
      }
      if (event.data.PlayerCounts == true) {
        document.getElementById("Yellow").innerHTML = "Yellow " + event.data.Yellow
        document.getElementById("Green").innerHTML = "Green " + event.data.Green
        document.getElementById("Blue").innerHTML = "Blue " + event.data.Blue
      }
      if (event.data.UpdatePoints == true) {
        document.getElementById("YellowPoints").innerHTML = event.data.Yellow
        document.getElementById("GreenPoints").innerHTML = event.data.Green
        document.getElementById("BluePoints").innerHTML = event.data.Blue
      }
    });
});

function StartPressed() {
  $.post('http://koth/WelcomeClosed', JSON.stringify({}));
}

function Gender(Gender) {
  if (Gender == "Male") {
    $.post('http://koth/GenderSelect', JSON.stringify({Gender: true}));
  } else {
    $.post('http://koth/GenderSelect', JSON.stringify({Gender: false}));
  }
}

function Team(team){
  $.post('http://koth/TeamSelect', JSON.stringify({Team: team}));
}
