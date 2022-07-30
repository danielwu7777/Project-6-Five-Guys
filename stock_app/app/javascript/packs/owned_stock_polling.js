// Created 7/26/2022 by Jake McCann
// This code is nearly identical to other polls, can be refactored
$(document).ready(function() {
    setInterval(function () {
        $.ajax({
            type: "POST",
            url: window.location.href + '/account_value_poll',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            success: function(response) {
                $('#user_money').html(response);
            }
        });
    } , 5000);
});

$(document).ready(function() {
    setInterval(function () {
        $.ajax({
            type: "POST",
            url: window.location.href + '/owned_stock_value_poll',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            success: function(response) {
                $('#stock_table').html(response);
            }
        });
    } , 5000);
});