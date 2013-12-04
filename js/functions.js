var mside = false; // initialise mouse-inside

$(document).ready(function () {
    // open the related modal window
    // pass the div id as the rel attribute
    $('body').on('click', '.js-open-modal', function () {
        var target = "#" + $(this).data("target");
        $('body, '+ target).addClass('md-show');
        return false;
    });

    $('body').on('click', '.sidebar-close', function () {
        toggleSidebar();
    });

    // toggle side panel
    if ($('.sidebar').length === 0) {
        $('.js-toggle-help').attr('disabled', 'disabled').unbind('click');
    } else {
        $('body').on('click', '.js-toggle-help', function () {
            toggleSidebar();
            return false;
        });
    }

    // toggle options menu
    $('.js-toggle-options').on('click', function () {
        toggleOptionsMenu();
        //$(this).parents('.nav-options').toggleClass('active');
    });


    // close modal if wrapper is clicked or button is closed
    $('body').on('click', '.md-wrapper, .md-close', function () {
        hideModal();
        return false;
    });

    function toggleOptionsMenu() {
        $('.nav-options').toggleClass('nav-options-active');
        return false;
    }

    // Listener for escape action, like pressing escape or clicking outside a modal
    //$('body').on('escapeAction', function () {
    //    toggleOptionsMenu(false);
    //});

    // close modal if escape is pressed
    $(document).keyup(function (e) {
        if (e.which == 27) {
            //$('body').trigger('escapeAction');
            hideModal();
        }
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

    $('body').on('click', '.flash', function () {
        $(this).remove();
        return false;
    });
});

// check for the next unread notification
function notificationCheck() {
    
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

function hideModal() {
    $('body, .md-window').removeClass('md-show');
}

function validateModal() {
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate();
    }

    if (Page_IsValid) {
        hideModal();
        return true;
    }
    return false;
}

function toggleSidebar() {
    $('body').toggleClass('show-sidebar');
}