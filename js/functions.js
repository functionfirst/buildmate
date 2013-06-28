var mside = false; // initialise mouse-inside

$(document).ready(function () {
    // open the related modal window
    // pass the div id as the rel attribute
    $(".open_modal").live("click", function () {
        var target = "#" + $(this).attr("rel");
        $(".modal-wrapper").fadeIn(function () {
            $(target).animate({ "top": "50%" });
        });

        return false;
    });

    // close modal if wrapper is clicked
    $(".modal-wrapper").click(function () {
        $(".modal-window").animate({ "top": "-50%" }, function () {
            $(".modal-wrapper").fadeOut();
        });

        return false;
    });

    // close modal window on close button click
    $(".modal-window").find(".close").click(function () {
        $(".modal-wrapper").click();
        return false;
    });

    // close modal if escape is pressed
    $(document).keyup(function (e) {
        if (e.which == 27) { $(".modal-wrapper").click(); }
        if ($("#variationMode").hasClass("active")) {
            hideVariationMode();
        }
    });

    $(".openVariatonMode").click(function () {
        $("#variationMode").toggleClass("active");
    });

    $(".notice").live("click", function () {
        $(this).fadeOut();
    });

    // show advanced search
    $(".toggleSearch").live("click", function () {
        $(this).parent().toggleClass('active');
    });

    // check mouse position in modal window
//    $('.search').hover(function () {
//        mside = true;
//    }, function () {
//        mside = false;
//    });

    // close search box
//    $("body").click(function () {
//        if (!mside) { $(".search").removeClass('active'); }
//    });

    // show notifications
    // move notification
 //   $(".noticePoint").animate({ "top": "0" }, 600);

    //    // hide notification
    //    $(".dismiss").click(function () {
    //        $(this).parent().fadeOut();
    //        notificationCheck();
    //        return false;
    //    })

    // toggle notification list in topbar
    //$(".noticeBadgeNew").click(function () {
    //    $(this).parent().toggleClass("active");
    //    return false;
    //});

    $(".help").click(function () {
      
        return false;
    });
});

// check for the next unread notification
function notificationCheck() {
    
}

// close modal window function
function closeModal() {
    $(".modal-window").animate({ "top": "-50%" }, function () {
        $(".modal-wrapper").fadeOut();
    });
}

function showVariationMode() {
    $("#variationMode").addClass("active");
}

function hideVariationMode() {
    $("#variationMode").removeClass("active");
}

/* notifications */
// hide notification
$(".dismiss").click(function () {
    $(this).parent().fadeOut();
    notificationCheck($(this).attr("rel"));
    return false;
})

function setMessage(text) {
    alert(text);
}

//function notificationCheck(id) {
//    WebService.setNotificationAsRead('B2B6D6D5-DCC1-4006-ABAE-8EFDE48B77F6', id);
//}

//var notifications = {
//    init: function () {
//        WebService.getLastNotification('B2B6D6D5-DCC1-4006-ABAE-8EFDE48B77F6', this.success, this.failure);
//        $('.dismiss').bind('click', this.hide);
//    },
//    success: function (result) {
//        var c = eval(result.d);
//        console.log(result);
//        for (var i in c) {
//            console.log(c[i][0]);
//            $("#resultstable tr:last").after("<tr><td>" + c[i][0] + "</td><td>" + c[i][1] + "</td><td>" + c[i][2] + "</td></tr>");
//        }
//    },
//    failure: function (error) {
//        alert(error.get_message());
//    },
//    hide: function () {
//        $(this).parent().fadeOut();
//        notificationCheck($(this).attr("rel"));
//        return false;
//    }
//}
//notifications.init();