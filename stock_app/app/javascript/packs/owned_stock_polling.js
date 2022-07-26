// Created 7/26/2022 by Jake McCann
$(document).ready(function() {
    setInterval(function () {
        $.ajax({url:'owned_stocks',success: window.location.reload()});
    } , 5000);
});