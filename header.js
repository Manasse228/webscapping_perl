var page = require('webpage').create();
  
page.open('http://www.kolayscript.com', function (status) {
    if (status !== 'success') {
        console.log('Connextion impossible à ce site');
    } else {
        var p = page.evaluate(function () {
            return document.getElementsByTagName('head')[0].innerHTML
        });
        //console.log(p);
        
var fs = require('fs');
fs.write("header.csv", p, 'w');
       
    }
    phantom.exit();
});
