var mside = false; // initialise mouse-inside

var bm = bm || {}; // namespace buildmate

$(document).ready(function () {
    // open the related modal window
    // pass the div id as the rel attribute
    $('body').on('click', '.js-open-modal', function () {
        var target = "[data-modal='" + $(this).data("target") + "']";
        $('body, '+ target).addClass('md-show');
        return false;
    });

    $('#tourTip').on('click', '.tour-close', closeTour);

    $('body').on('click', '.js-move-tour', bm.tour);

    $('body').on('click', '.tour-tooltip-video a', launchVideo);
    $('body').on('click', '.video-modal', closeVideo);

    // tabs for tour
    $('[data-tour="menu"]').find('a[data-tab]').on('click', changeTourVideo);
    

    function changeTourVideo(){
        var target = $(this).data('tab');
        $('.js-tour-links').find('li').removeClass('active');
        $(this).parent().addClass('active');
        $('[data-target="' + target + '"]').removeClass('hide').siblings().addClass('hide');
        return false;
    }

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
        closeVideo();
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

    $('body').on('click', '#DisplayHelpCenter', enableTour);
});

function enableTour() {
    $.ajax({
        url: 'toggle_help.aspx?show=true'
    });
    showHelp = true;
    bm.tour(data);
    $('body').addClass('has-tour');
    return false;
}

function closeTour() {
    $('body').removeClass('has-tour');
    $.ajax({
        url: 'toggle_help.aspx?show=false'
    });
    return false;
}

function launchVideo() {
    var id = $(this).data('id');
    $('#videoFrame').attr('src', '//www.youtube.com/embed/' + id);
    $('#videoModal').addClass('show-video');
    return false;
}

function closeVideo() {
    $('#videoModal').removeClass('show-video');
    $('#videoFrame').attr('src', '')
}



// check for the next unread notification
function showVariationMode() {
    $("#variationMode").addClass("active");
}

function hideVariationMode() {
    $("#variationMode").removeClass("active");
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


// buildmate tour controls
bm.tour = function (data) {
    if (!showHelp) {
        //$("#tour-tooltip").hide()
        return;
    }

    var source = $("#tour-tooltip").html(),
        template = Handlebars.compile(source),
        html = template(data.tooltip);

    $('#tourTip').html(html);
    $('body').addClass('has-tour');
}

function debounce(func, wait, immediate) {
    var timeout;
    return function () {
        var context = this, args = arguments;
        var later = function () {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
};