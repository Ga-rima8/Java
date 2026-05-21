const adventureData = [
    {
        id: 1, type: 'Air', title: 'Halo Jump: Void Zero',
        desc: 'A high-altitude military style jump from the edge of the atmosphere. Experience 2 minutes of pure silence before the terminal velocity kicks in.',
        img: 'img/A2.png',
        price: '$2,400', inventor: 'Viktor Thorne', org: 'Stratosphere Elite',
        venue: 'Nevada Dead Zone', size: '4 Members',
        history: 'Originally a secret military training drill in 1998.'
    },
    {
        id: 2, type: 'Water', title: 'The Abyss Dive',
        desc: 'Technical cave diving into the sapphire sinkholes of the Yucatan. Navigate through prehistoric stalactites in crystal clear, lightless waters.',
        img: 'img/A1.png',
        price: '$1,850', inventor: 'Elena Vance', org: 'Deep Ghost Explorers',
        venue: 'Cenote Xibalba', size: '2 Members',
        history: 'Awarded "Dive of the Year" by NatGeo in 2024.'
    },
    {
        id: 3, type: 'Land', title: 'Neon Ridge Trek',
        desc: "A midnight climb up the basalt cliffs of Iceland during the peak of the Northern Lights. No artificial lights allowed—just nature's glow.",
        img: 'img/A5.png',
        price: '$950', inventor: 'Lars Sigurson', org: 'Arctic Ghosts',
        venue: 'Vatnajokull', size: '10 Members',
        history: 'An ancient path used by nomadic tribes, rediscovered in 2012.'
    },
    {
        id: 4, type: 'Air', title: 'Thermal Paragliding',
        desc: 'Soar above the Himalayas using nothing but thermal wind currents. Reach altitudes usually reserved for golden eagles.',
        img: 'img/A3.png',
        price: '$1,200', inventor: 'Sanjay Thapa', org: 'Wind Whisperers',
        venue: 'Pokhara Ridge', size: 'Solo/Tandem',
        history: 'Longest thermal flight recorded in Asia happened here.'
    },
    {
        id: 5, type: 'Water', title: 'Ice Floe Kayaking',
        desc: 'Navigate through moving glaciers in the Antarctic. A silent journey through the white desert of the south.',
        img: 'img/A4.png',
        price: '$3,100', inventor: 'Cmdr. Richard Byrd', org: 'South Pole Expeditions',
        venue: 'Ross Sea', size: '6 Members',
        history: 'Follows the 1928 exploration route.'
    },
    {
        id: 6, type: 'Land', title: 'Hot AirRide',
        desc: 'An off-grid survival experience in the deepest crevices of the Grand Canyon. No phones, no tech, just the red dust.',
        img: 'img/A6.png',
        price: '$700', inventor: 'Chief Sitting Bear', org: 'Ancestral Trails',
        venue: 'Arizona Sector G', size: '8 Members',
        history: 'Maintained by local tribes for over 400 years.'
    }
];

function goToBooking(id) {
    const item = adventureData.find(i => i.id === id);
    const params = new URLSearchParams({
        title : item.title,
        type  : item.type,
        price : item.price,
        venue : item.venue,
        desc  : item.desc,
        org   : item.org,
        size  : item.size,
        hist  : item.history,
        inv   : item.inventor,
        img   : item.img
    });
    window.location.href = CTX + '/Booking?' + params.toString();
}

function renderGrid(data) {
    const grid = document.getElementById('mainGrid');
    grid.innerHTML = '';
    requestAnimationFrame(() => {
        grid.innerHTML = data.map((item, i) => `
            <div class="card" onclick="goToBooking(${item.id})" style="animation-delay:${i * 0.07}s">
                <img src="${item.img}" class="card-img" alt="${item.title}">
                <div class="card-content">
                    <span class="card-tag">${item.type}</span>
                    <h3 class="card-title">${item.title}</h3>
                    <div class="card-meta">Starting at ${item.price} &bull; ${item.venue}</div>
                    <div class="card-cta">Book Now &rarr;</div>
                </div>
            </div>
        `).join('');
    });
}

function filterData(category, el) {
    document.querySelectorAll('.filter-link').forEach(link => link.classList.remove('active'));
    el.classList.add('active');
    el.classList.remove('pulse');
    void el.offsetWidth;
    el.classList.add('pulse');
    const filtered = category === 'all'
        ? adventureData
        : adventureData.filter(item => item.type === category);
    renderGrid(filtered);
}

renderGrid(adventureData);