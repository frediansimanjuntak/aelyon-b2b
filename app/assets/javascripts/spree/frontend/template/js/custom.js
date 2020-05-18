function nextTab(elem) {
  $(elem).next().find('a[data-toggle="tab"]').click();
}
function prevTab(elem) {
  console.log(elem);
  $(elem).prev().find('a[data-toggle="tab"]').click();
}

$(document).on("turbolinks:load",function(){
  $('.register-personal-form').hide();
  $('.register-company-form').hide();

  $('.register-personal').click(function() {
    $('.register-button').hide();
    $('.register-personal-form').show();
    $('.register-company-form').hide();
  });

  $('.register-company').click(function() {
    $('.register-button').hide();
    $('.register-personal-form').hide();
    $('.register-company-form').show();
  });

  $('.register-cancel').click(function() {
    $('.register-button').show();
    $('.register-personal-form').hide();
    $('.register-company-form').hide();
  })


  /////
  var current_fs, next_fs, previous_fs; //fieldsets
  var opacity;

  $(".next").click(function(){

    current_fs = $(this).parent();
    next_fs = $(this).parent().next();

    //Add Class Active
    $("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");

    //show the next fieldset
    next_fs.show();
    //hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
      step: function(now) {
        // for making fielset appear animation
        opacity = 1 - now;

        current_fs.css({
          'display': 'none',
          'position': 'relative'
        });
        next_fs.css({'opacity': opacity});
      },
      duration: 600
    });
  });

  $(".previous").click(function(){

    current_fs = $(this).parent();
    previous_fs = $(this).parent().prev();

    //Remove class active
    $("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

    //show the previous fieldset
    previous_fs.show();

    //hide the current fieldset with style
    current_fs.animate({opacity: 0}, {
      step: function(now) {
        // for making fielset appear animation
        opacity = 1 - now;

        current_fs.css({
          'display': 'none',
          'position': 'relative'
        });
        previous_fs.css({'opacity': opacity});
      },
      duration: 600
    });
  });

  $('.radio-group .radio').click(function(){
    $(this).parent().find('.radio').removeClass('selected');
    $(this).addClass('selected');
  });

  $(".submit").click(function(){
    return false;
  })
})