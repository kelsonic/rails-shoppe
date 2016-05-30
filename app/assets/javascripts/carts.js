$(document).ready(function() {
  $('.product-show').on('submit', "#add-to-cart-form", function(event) {
    event.preventDefault();

    var data = $(this).serialize();

    $.ajax({
      method: 'GET',
      url: '/carts/new',
      data: data
    })

    .done(function(msg) {
      $(".product-show").append("<br/><br/>" + msg);
      $("#add-to-cart-form").hide();
    })

    .fail(function(err) {
      console.log(err);
    })
  })
})
