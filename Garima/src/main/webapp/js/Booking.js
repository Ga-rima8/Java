// ── Level picker ──
document.querySelectorAll('.level-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        document.querySelectorAll('.level-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.getElementById('expLevel').value = btn.dataset.level;
    });
});

// ── Drag & drop on upload zone ──
const uploadZone = document.getElementById('uploadZone');

uploadZone.addEventListener('dragover', e => {
    e.preventDefault();
    uploadZone.classList.add('drag-over');
});

uploadZone.addEventListener('dragleave', () => {
    uploadZone.classList.remove('drag-over');
});

uploadZone.addEventListener('drop', e => {
    e.preventDefault();
    uploadZone.classList.remove('drag-over');
    const file = e.dataTransfer.files[0];
    if (file && file.type.startsWith('image/')) {
        showPreview(file);
        const dt = new DataTransfer();
        dt.items.add(file);
        document.getElementById('cidFile').files = dt.files;
    }
});

function triggerUpload() {
    if (!document.getElementById('uploadPreview').classList.contains('show')) {
        document.getElementById('cidFile').click();
    }
}

function handleFile(input) {
    const file = input.files[0];
    if (file) showPreview(file);
}

function showPreview(file) {
    const reader = new FileReader();
    reader.onload = e => {
        document.getElementById('previewImg').src = e.target.result;
        document.getElementById('previewName').textContent = file.name;
        document.getElementById('uploadInner').style.display = 'none';
        const prev = document.getElementById('uploadPreview');
        prev.style.display = 'flex';
        prev.classList.add('show');
        uploadZone.style.padding = '20px';
    };
    reader.readAsDataURL(file);
}

function removeImage(e) {
    e.stopPropagation();
    document.getElementById('previewImg').src = '';
    document.getElementById('previewName').textContent = '';
    document.getElementById('cidFile').value = '';
    document.getElementById('uploadPreview').classList.remove('show');
    document.getElementById('uploadPreview').style.display = 'none';
    document.getElementById('uploadInner').style.display = 'flex';
    uploadZone.style.padding = '40px 20px';
}

// ── Submit ──
function submitBooking(e) {
    e.preventDefault();
    const btn = document.getElementById('submitBtn');
    btn.classList.add('loading');
    btn.querySelector('.btn-text').textContent = 'Processing';

    setTimeout(() => {
        document.getElementById('pageWrap').style.opacity    = '0';
        document.getElementById('pageWrap').style.transform  = 'scale(0.97)';
        document.getElementById('pageWrap').style.transition = 'all 0.5s ease';

        setTimeout(() => {
            document.getElementById('pageWrap').style.display = 'none';
            document.getElementById('confirmScreen').classList.add('show');
        }, 500);
    }, 1800);
}

// ── Staggered field entrance animation ──
window.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.field, .terms-row, .submit-btn').forEach((el, i) => {
        el.style.opacity   = '0';
        el.style.transform = 'translateY(16px)';
        setTimeout(() => {
            el.style.transition = 'opacity 0.4s ease, transform 0.4s ease';
            el.style.opacity    = '1';
            el.style.transform  = 'translateY(0)';
        }, 300 + i * 70);
    });
});