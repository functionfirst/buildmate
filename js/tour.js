(function () {
    var phase = [];

    phase['0/'] = {
        hide: '#MainContent_pTour1, #MainContent_pMainPanel, #hlProjects, #hlSuppliers, #hlResources, #hlSupport',
        blink : '#hlCustomers'
    }

    phase['0/customers.aspx'] = {
        hide: '#MainContent_pTour1, #MainContent_pMainPanel, #hlProjects, #hlSuppliers, #hlResources, #hlSupport',
        blink: '.button-create'
    }

    phase['0/settings.aspx'] = {
        hide: '#hlProjects, #hlSuppliers, #hlResources, #hlSupport',
        blink: '.button-create'
    }

    phase['0/videos.aspx'] = {
        hide: '#hlProjects, #hlSuppliers, #hlResources, #hlSupport',
        blink: '.button-create'
    }

    // phase 1
    phase['1/'] = {
        hide: '#MainContent_pTour0, #MainContent_pMainPanel, #hlSuppliers, #hlResources, #hlSupport',
        blink: '#hlProjects'
    }
    phase['1/projects.aspx'] = {
        hide: '#MainContent_pTour0, #MainContent_pMainPanel, #hlSuppliers, #hlResources, #hlSupport',
        blink: ''
    }
    phase['1/customers.aspx'] = {
        hide: '#MainContent_pTour0, #hlProjects, #hlSuppliers, #hlResources, #hlSupport',
        blink: ''
    }

    var key = tour.current_phase + window.location.pathname,
        hide = phase[key].hide,
        blink = phase[key].blink;

    $(hide).hide();
    $(blink).addClass('blink-me')
})();