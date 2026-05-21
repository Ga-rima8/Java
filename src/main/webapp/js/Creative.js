const adventureData = [
	{
	    id: 1, type: 'Air', title: 'Halo Jump: Void Zero',
	    desc: 'A high-altitude military style jump from the edge of the atmosphere. Experience 2 minutes of pure silence before the terminal velocity kicks in.',
	    img: 'img/C2.',
	    price: '$2,400', inventor: 'Viktor Thorne', org: 'Stratosphere Elite',
	    venue: 'Nevada Dead Zone', size: '4 Members',
	    history: 'Originally a secret military training drill in 1998.'
	},
    {
        id: 2, type: 'Performative', title: 'Performative',
        desc: 'All the emotions to be run through. Classical Drama.',
        img: 'img/C3.png',
        price: 'NPR 1500', inventor: 'Elena Vance', org: 'Deep Ghost Explorers',
        venue: 'Cenote Xibalba', size: '2 Members',
        history: 'Awarded "Drama of the Year" by ClassicGeo in 2024.'
    },
    {
        id: 3, type: 'Literary', title: 'Literary',
        desc: "A midnight climb up the basalt cliffs under Northern Lights. No artificial lights with just Books",
        img: 'img/C1.png',
        price: 'NPR 200', inventor: 'Lars Sigurson', org: 'Arctic Ghosts',
        venue: 'Vatnajokull', size: '10 Members',
        history: 'An ancient library with Books since 1912.'
    },
    {
		id: 4, type: 'Visual', title: 'Visual',
		       desc: 'Crafts to build out our creative side',
		       img: 'img/C2.png',
		       price: 'NPR 500', inventor: 'Viktor Thorne', org: 'Stratosphere Elite',
		       venue: 'Nevada Dead Zone', size: '4 Members',
		       history: 'Originally a secret Art training drill in 1998.'
    },
    {
		id: 5, type: 'Performative', title: 'Performative',
		       desc: 'All the emotions to be run through. Classical Drama.',
		       img: 'img/C3.png',
		       price: 'NPR 1500', inventor: 'Elena Vance', org: 'Deep Ghost Explorers',
		       venue: 'Cenote Xibalba', size: '2 Members',
		       history: 'Awarded "Drama of the Year" by ClassicGeo in 2024.'
    },
    {
		id: 6, type: 'Literary', title: 'Literary',
		       desc: "A midnight climb up the basalt cliffs under Northern Lights. No artificial lights with just Books",
		       img: 'img/C1.png',
		       price: 'NPR 200', inventor: 'Lars Sigurson', org: 'Arctic Ghosts',
		       venue: 'Vatnajokull', size: '10 Members',
		       history: 'An ancient library with Books since 1912.'
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