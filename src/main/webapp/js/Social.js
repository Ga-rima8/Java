const adventureData = [
    {
        id: 1, type: 'Community', title: 'Community',
        desc: ' Experience pure Freindship and endless activities',
        img: 'img/S1.png',
        price: '$150', inventor: 'Viktor Thorne', org: 'Stratosphere Elite',
        venue: 'Nevada Dead Zone', size: '4 Members',
        history: 'Secret Club for people who beilve in having fun.'
    },
    {
        id: 2, type: 'Networking', title: 'Networking ',
        desc: 'Engage in endless talk and event to build your portfolio',
        img: 'img/S2.png',
        price: 'NPR 850', inventor: 'Elena Vance', org: 'Deep Ghost Explorers',
        venue: 'Cenote Xibalba', size: '2 Members',
        history: 'Biggest Peoples Hub in Nepal'
    },
    {
        id: 3, type: 'Celebration', title: 'Celebration',
        desc: "A midnight Jam or morning brunch we have it all in the best way.",
        img: 'img/S3.png',
        price: 'NPR 950', inventor: 'Lars Sigurson', org: 'Arctic Ghosts',
        venue: 'Vatnajokull', size: '10 Members',
        history: 'DRINK, EAT, SLEEP AND REPEAT'
    },
    {
		id: 4, type: 'Community', title: 'Community',
		        desc: ' Experience pure Freindship and endless activities',
		        img: 'img/S1.png',
		        price: '$150', inventor: 'Viktor Thorne', org: 'Stratosphere Elite',
		        venue: 'Nevada Dead Zone', size: '4 Members',
		        history: 'Secret Club for people who beilve in having fun.'
    },
    {
		id: 5, type: 'Networking', title: 'Networkworking ',
		        desc: 'Engage in endless talk and event to build your portfolio',
		        img: 'img/S2.png',
		        price: 'NPR 850', inventor: 'Elena Vance', org: 'Deep Ghost Explorers',
		        venue: 'Cenote Xibalba', size: '2 Members',
		        history: 'Biggest Peoples Hub in Nepal'
    },
    {
		id: 6, type: 'Celebration', title: 'Celebrating',
		        desc: "A midnight Jam or morning brunch we have it all in the best way.",
		        img: 'img/S3.png',
		        price: 'NPR 950', inventor: 'Lars Sigurson', org: 'Arctic Ghosts',
		        venue: 'Vatnajokull', size: '10 Members',
		        history: 'DRINK, EAT, SLEEP AND REPEAT'
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