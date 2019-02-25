$(document).ready(function(){
    $("button").click(function(){
        $("#div1").fadeTo("slow", 0.05);
        $("#div2").fadeOut("slow");
        $("#div3").fadeOut(3000);
    });
});