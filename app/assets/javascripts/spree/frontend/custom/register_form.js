$(document).on("turbolinks:load",function(){ 
    /////
    var current_fs, next_fs, previous_fs; //fieldsets
    var opacity;
  
    $(".next").click(function(){
      parent = $(this).parent();
      head_parent = parent.parent();
      current_fs = head_parent.parent();
      next_fs = head_parent.parent().next();
      console.log(current_fs);
  
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
      parent = $(this).parent();
      head_parent = parent.parent();
      current_fs = head_parent.parent();
      previous_fs = head_parent.parent().prev();
  
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