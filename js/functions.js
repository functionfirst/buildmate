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

    bm.tour.get();

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
bm.tour = {
    get: function (data) {
        if (bm.tour.current_phase < 10) {
            var path = window.location.pathname.replace(".aspx", "");
            path = path === '/' ? '/default' : path
            var uri = "tour{0}.json".replace("{0}", path);

            $.getJSON(uri, function (json) {
                bm.tour.process(json[bm.tour.current_phase]);
            })
            .fail(function () {
                $('#tour').hide();
            });
        }
    },

    process: function (data) {
        if (typeof data.content !== 'undefined') {
            var elem = $('#tour').find('.container');
            $(data.hide).hide();
            $(data.blink).addClass('blink-me');
            elem.html(data.content);
            if (data.image) {
                elem.css('background-image', 'url(/tour/images/' + data.image + ')');
            }
            elem.prepend('<a class="tour-button button button-large" href="https://youtu.be/QxhB-S1UoG4" target="_blank">Watch Tutorial Help</a>')
            elem.append('<div class="tour-progress tour-' + bm.tour.current_phase + '"><span></span></div>')
            $('#tour').show();
        }
    }
}