const formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
  minimumFractionDigits: 0
})

function move(perc, maxLvl, curLvl) {
    var elem = document.getElementById("myBar");
    var lvl = document.getElementById('lvl');
    lvl.innerHTML = curLvl + "/" + maxLvl
    elem.style.width = perc + "%";
}


$(function()
{
    $('#items-container').show();
    $('#wep-container').hide();
    $('#veh-container').hide();
    var money = 0
    window.addEventListener('message', function(event)
    {

      var userLevel = event.data.level
      if (userLevel) {
        move(event.data.perc, event.data.maxLvl, event.data.curLvl)
        $('#lvl-hud').html("Lvl: " + userLevel)
      }

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

      if (event.data.money != null) {
        money = event.data.money
        $('#money-hud').html(formatter.format(money))
      }

      if (event.data.Copy != null) {
        setClipboard(event.data.Copy)
      }


      var weapons = event.data.weapons;
      var vehicles = event.data.vehicles;
      userLvl = event.data.userLvl
      vehiceleLvl = event.data.vehicleLvl;
      if (userLvl) {
        for (let [key, value] of Object.entries(weapons)) {
          $('#weapon-list').append(
          '<div id="weapon-box"><img src="./assets/' + value.Model +'.png"><p> ' + formatter.format(value.price) + ' | Lvl: ' + value.levelReq +'</p><button id="'+ key +'" onclick="buyWeapon(this)" ' + (userLvl < value.levelReq ? "disabled" : null) + '>'+ (userLvl < value.levelReq ? "Not available" : "Buy") +'</button></div>')
        }
      }

      if (vehiceleLvl) {
        for (let [key, value] of Object.entries(vehicles)) {
          $('#vehicle-list').append(
          '<div id="vehicle-box"><img src="./assets/' + value.Model +'.png"><p> ' + formatter.format(value.price) + ' | Lvl: ' + value.levelReq +'</p><button id="'+ key +'" onclick="buyVehicle(this)" ' + (lvl < value.levelReq ? "disabled" : null) + '>'+ (lvl < value.levelReq ? "Not available" : "Buy") +'</button></div>')
        }
      }
    });

    // THE SHOP

    // Items
    $('#item-btn').click(function() {
      $('#items-container').show();
      $('#wep-container').hide();
      $('#veh-container').hide();
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
  $.post('https://KOTH/WelcomeClosed', JSON.stringify({}));
}

function Gender(Gender) {
  if (Gender == "Male") {
    $.post('https://KOTH/GenderSelect', JSON.stringify({Gender: true}));
  } else {
    $.post('https://KOTH/GenderSelect', JSON.stringify({Gender: false}));
  }
}

function Team(team){
  $.post('https://KOTH/TeamSelect', JSON.stringify({Team: team}));
}

// SHOP
function closeShop() {
  $.post('https://KOTH/koth:shop:close', JSON.stringify({}));
}

function buyWeapon(elem) {
  console.log(elem.id)
  $.post('https://KOTH/koth:ui:buyWeapons', JSON.stringify({
    weapon: elem.id
  }))
}

function buyVehicle(elem) {
  console.log(elem.id)
  $.post('https://KOTH/koth:ui:buyVehicles', JSON.stringify({
    vehicle: elem.id
  }))
}

function setClipboard(value) {
  var tempInput = document.createElement("input");
  tempInput.style = "position: absolute; left: -1000px; top: -1000px";
  tempInput.value = value;
  document.body.appendChild(tempInput);
  tempInput.select();
  document.execCommand("copy");
  document.body.removeChild(tempInput);
}
