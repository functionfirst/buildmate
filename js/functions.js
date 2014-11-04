var mside = false; // initialise mouse-inside

$(document).ready(function () {
    // open the related modal window
    // pass the div id as the rel attribute
    $('body').on('click', '.js-open-modal', function () {
        var target = "#" + $(this).data("target");
        $('body, '+ target).addClass('md-show');
        return false;
    });

    // tabs for tour
    $('[data-tour="menu"]').find('a[data-tab]').click(function () {
        var target = $(this).data('tab');
        $(this).parent().addClass('active').siblings().removeClass('active');
        $('[data-target="' + target + '"]').removeClass('hide').siblings().addClass('hide');
        return false;
    });

    // shortcut for tour tabs
    $('[data-tab-control]').click(function () {
        var target = $(this).data('tab-control');
        $('a[data-tab="' + target + '"]').trigger('click');
    });

    // toggle options menu
    $('[data-toggle-menu]').on('click', function () {
        var target = $(this).data("toggle-menu");
        $('[data-target]').not('[data-target="'+target+'"]').removeClass("active")
        toggleVisibility('[data-target="'+target+'"]', 'active');
        return false;
    });

    var tour = getTour();

    // close options menu after clicking
    $('.options-icon').click(function () {
        toggleVisibility('.nav-options', 'nav-options-active', false);
    });


    // close modal if wrapper is clicked or button is closed
    $('body').on('click', '.md-wrapper, .md-close', function () {
        hideModal();
        return false;
    });

    // tooltips
    $('body').on('click', '.tooltip', function () {
        $(this).toggleClass('tooltip-active');
        return false;
    });

    function hideTooltips() {
        $('.tooltip').removeClass('tooltip-active');
    }

    // Listener for escape action, like pressing escape or clicking outside a modal
    $('body').on('escapeAction', function () {
        toggleVisibility('body', 'show-tour', false)
        //toggleVisibility('.nav-options', 'nav-options-active', false);
        toggleVisibility('[data-target]', 'active', false);
        hideTooltips();
    });

    $('.main-container').on('click', function () {
        toggleVisibility('.nav-options', 'nav-options-active', false);
        toggleVisibility('[data-target]', 'active', false);
        hideTooltips();
    });

    // close modal if escape is pressed
    $(document).keyup(function (e) {
        if (e.which == 27) {
            $('body').trigger('escapeAction');
            hideModal();
        }
        if ($("#variationMode").hasClass("active")) {
            hideVariationMode();
        }
    });

    $(".openVariatonMode").click(function () {
        $("#variationMode").toggleClass("active");
    });

    // show advanced search
    $("body").on("click", ".toggleSearch", function (e) {
        e.preventDefault();
        var target = $(this).attr('href');
        $(target).toggleClass('active');
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

function toggleVisibility(elem, klassName, set) {
    $(elem).toggleClass(klassName, set);
}

function getTour() {
    var uri = (tour.current_phase + window.location.pathname).replace('.aspx', '').replace('/', '-') + '.js';
    $.ajax({
        url: 'tour/' + uri,
        success: function (response) {
            runTour(eval(response)[0]);
        }
    });
}

function runTour(data) {
    $(data.hide).hide();
    $(data.blink).addClass('blink-me');
    $('#tour').html( data.content );
}