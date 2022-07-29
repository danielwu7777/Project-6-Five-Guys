// Created 7/26/2022 by Jake McCann
// This code is nearly identical to other polls, can be refactored
$(document).ready(function() {
    setInterval(function () {
        $.ajax({
            type: "POST",
            url: 'stock_poll',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            success: function(response) {
                $('#stock_table').html(response);
            }
        });
    } , 5000);
});