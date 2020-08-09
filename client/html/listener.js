$(function()
{
    $('#items-container').show();
    $('#wep-container').hide();
    $('#veh-container').hide();
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
      if (event.data.ShopUI == true) {
        document.getElementById("Shop").style.display = "block";
      } else if (event.data.ShopUI == false) {
        document.getElementById("Shop").style.display = "none";
      }
      if (event.data.PlayerCounts == true) {
        $("#Yellow").html("Yellow: " + event.data.Yellow + " players").css("font-family", 'Montserrat');
        $("#Green").html("Green: " + event.data.Green + " players").css("font-family", 'Montserrat');
        $("#Blue").html("Blue: " + event.data.Blue + " players").css("font-family", 'Montserrat');
      }
      if (event.data.UpdatePoints == true) {
        document.getElementById("YellowPoints").innerHTML = event.data.Yellow
        document.getElementById("GreenPoints").innerHTML = event.data.Green
        document.getElementById("BluePoints").innerHTML = event.data.Blue
      }
      if (event.data.Win == true) {
        document.getElementById("Win").style.display = "block";
        document.getElementById("WinText").innerHTML = "<span class='" + event.data.WinningTeam + "'>" + event.data.WinningTeam + "</span> team has won.";
      } else if (event.data.Win == false) {
        document.getElementById("Win").style.display = "none";
        document.getElementById("WinText").innerHTML = "";
      }
    });


    // THE SHOP

    // Items
    $('#item-btn').click(function() {
      $('#items-container').show();
      $('#wep-container').hide();
      $('#veh-container').hide();
      console.log("FUCK")
    })
    
    // WPep
    $('#wep-btn').click(function() {
      $('#wep-container').show();
      $('#items-container').hide();
      $('#veh-container').hide();
      console.log("FUCK")
    })
    
    // Veh
    $('#veh-btn').click(function() {
      $('#veh-container').show();
      $('#items-container').hide();
      $('#wep-container').hide();
      console.log("FUCK")
    })

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

// SHOP
function closeShop() {
  $.post('http://koth/koth:shop:close', JSON.stringify({}));
}