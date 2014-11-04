(function () {
    var phase = [];

    phase['0/'] = {
        hide: '#MainContent_pMainPanel, #hlProjects, #hlSuppliers, #hlResources, #hlSupport',
        blink: '#hlCustomers',
        content : '<h2>Welcome to Buildmate</h2><p>To get started we\'re going to walk you through how to add your first Customer.</p><p>Click the <strong>Customers</strong> link in black bar at the top of the page begin.</p>'
    }

    phase['0/customers.aspx'] = {
        hide: '#MainContent_pTour1, #MainContent_pMainPanel, #hlProjects, #hlSuppliers, #hlResources, #hlSupport',
        blink: '.button-create',
        content : '<h2>Customer Management</h2><p>On this page you will manage all of your Customer information such as contact details and addresses. This is also where you\'ll add New Customers which is the next step on this Tour.</p><p>To add a Customer click the flashing green <strong>New Customer</strong> button to the top right of this page (This will pop open a new window).</p>'
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
        blink: '#hlProjects',
        content : '<h2>Creating Projects</h2><p>Now that you\'ve successfully create a Customer the next step of the Tour will guide you through creating a Project.</p><p>Click the <strong>Projects</strong> link above to begin.</p>'
    }

    phase['1/projects.aspx'] = {
        hide: '#MainContent_pTour0, #MainContent_pMainPanel, #hlSuppliers, #hlResources, #hlSupport',
        blink: '.button-create',
        content: '<h2>Create a Project</h2><p>This page is where you will create and manage your Projects.</p><p>To add a Project click the flashing green <strong>New Project</strong> button to the top right of this page.</p>'
    }
    phase['1/customers.aspx'] = {
        hide: '#MainContent_pTour0, #hlSuppliers, #hlResources, #hlSupport',
        blink: '#hlProjects',
        content: '<h2>Creating Projects</h2><p>Now that you\'ve successfully create a Customer the next step of the Tour will guide you through creating a Project.</p><p>Click the <strong>Projects</strong> link above to begin.</p>'
    }
    phase['1/add_project.aspx'] = {
        hide: '#MainContent_pTour0, #hlSuppliers, #hlResources, #hlSupport',
        blink: '#hlProjects',
        content: '<h2>Adding a Project</h2><p>First select the type of Estimate you wish to create.</p>'
    }

    // phase 2

    var key = tour.current_phase + window.location.pathname,
        hide = phase[key].hide,
        blink = phase[key].blink,
        content = phase[key].content;

    $(hide).hide();
    $(blink).addClass('blink-me')
    $('#tour').html(content);
})();