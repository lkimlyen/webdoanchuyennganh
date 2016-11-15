
if ($('.girl-phone').attr('data-pro') == '1') {
    $('.girl-phone').attr('data-join', $('#productId').val());
}

var phoneBoxType = $('.girl-phone').attr('data-type');
var phoneBoxJoinId = $('.girl-phone').attr('data-join');

$.get("/Ajax/Home/PhoneBox", { type: phoneBoxType, joindId: phoneBoxJoinId })
  .done(function (data) {
      $('.girl-phone').html(data);
  });