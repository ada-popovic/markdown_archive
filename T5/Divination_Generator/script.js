
window.onload = function() {

    //create a new instance of shake.js.
    var myShakeEvent = new Shake({
        threshold: 15
    });

    // start listening to device motion
    myShakeEvent.start();

    // register a shake event
    window.addEventListener('shake', shakeEventDidOccur, false);

    //shake event callback
    function shakeEventDidOccur () {

        //put your own code here etc.
        // alert('snow!');

        location.reload();
        // document.getElementById("square").style.backgroundImage = "url("snowfall.gif")";

    }
};

var myArray1 = [
  "education",
  "freedom",
  "law",
  "state",
  "religion",
  "brain",
  "hand",
  "perseus",
  "magic cap",
  "work",
  "thrift",
  "greed"
];

var randomItem1 = myArray1[Math.floor(Math.random()*myArray1.length)];

document.getElementById('word1').innerHTML = randomItem1;

var myArray2 = [
  "products",
  "virtues",
  "monsters"
];


var randomItem2 = myArray2[Math.floor(Math.random()*myArray2.length)];




document.getElementById('word2').innerHTML = randomItem2;


var myArray3 = [
  "education",
  "freedom",
  "law",
  "state",
  "religion",
  "brain",
  "hand",
  "perseus",
  "magic cap",
  "work",
  "thrift",
  "greed"
];


var randomItem3 = myArray3[Math.floor(Math.random()*myArray3.length)];

document.getElementById('word3').innerHTML = randomItem3;




var myArray4 = [
  "products",
  "virtues",
  "monsters"
];


var randomItem4 = myArray4[Math.floor(Math.random()*myArray4.length)];

document.getElementById('word4').innerHTML = randomItem4;





var myArray5 = [
  "education",
  "freedom",
  "law",
  "state",
  "religion",
  "brain",
  "hand",
  "perseus",
  "magic cap",
  "work",
  "thrift",
  "greed"
];


var randomItem5 = myArray5[Math.floor(Math.random()*myArray5.length)];

document.getElementById('word5').innerHTML = randomItem5;
