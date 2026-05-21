const TrailsData = [
    {
        id: 1, type: 'Bus', title: 'Bus',
        desc: 'Perfect beginning to a bulding memo',
        img: 'img/T2.png',
        price: 'NPR 2,400', inventor: 'Viktor Thorne', org: 'Stratosphere Elite',
        venue: 'Nevada Dead Zone', size: '4 Members',
        history: 'Originally a  military training vehicle company'
    },
    {
        id: 2, type: 'Car', title: 'Car',
        desc: 'Perfect beginning to a bulding memo',
        img: 'img/T3.png',
        price: 'NPR 850', inventor: 'Elena Vance', org: 'Deep Ghost Explorers',
        venue: 'Cenote Xibalba', size: '2 Members',
        history: 'Awarded "CAR of the Year" by NatGeo in 2024.'
    },
    {
        id: 3, type: 'Jeep', title: 'Jeep',
        desc: "A midnight climb Ride up the basalt cliffs of Iceland during the peak of the Northern Lights. No artificial lights allowed—just nature's glow.",
        img: 'img/T1.png',
        price: 'NPR 1550', inventor: 'Lars Sigurson', org: 'Arctic Ghosts',
        venue: 'Vatnajokull', size: '10 Members',
        history: 'An ancient path used by nomadic tribes, rediscovered in 2012.'
    },
    {
		id: 4, type: 'Bus', title: 'Bus',
		       desc: 'Perfect beginning to a bulding memo',
		       img: 'img/T2.png',
		       price: 'NPR 2,400', inventor: 'Viktor Thorne', org: 'Stratosphere Elite',
		       venue: 'Nevada Dead Zone', size: '4 Members',
		       history: 'Originally a  military training vehicle company'
    },
    {
		id: 5, type: 'Car', title: 'Car',
		       desc: 'Perfect beginning to a bulding memo',
		       img: 'img/T3.png',
		       price: 'NPR 850', inventor: 'Elena Vance', org: 'Deep Ghost Explorers',
		       venue: 'Cenote Xibalba', size: '2 Members',
		       history: 'Awarded "CAR of the Year" by NatGeo in 2024.'
    },
    {
		id: 6, type: 'Jeep', title: 'Jeep',
		        desc: "A midnight climb Ride up the basalt cliffs of Iceland during the peak of the Northern Lights. No artificial lights allowed—just nature's glow.",
		        img: 'img/T1.png',
		        price: 'NPR 1550', inventor: 'Lars Sigurson', org: 'Arctic Ghosts',
		        venue: 'Vatnajokull', size: '10 Members',
		        history: 'An ancient path used by nomadic tribes, rediscovered in 2012.'
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
    window.location.href = '/Garima/Booking?' + params.toString();
}

function renderGrid(data) {
    const grid = document.getElementById('mainGrid');
    grid.innerHTML = '';
    requestAnimationFrame(() => {
        grid.innerHTML = data.map((item, i) => `
            <div class="card" onclick="goToBooking(${item.id})" style="animation-delay:${i * 0.07}s">
                <img src="/Garima/${item.img}" class="card-img" alt="${item.title}">
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