// Home.js

/* Navbar scroll effect */
window.addEventListener('scroll', () => {
  const nav = document.getElementById('navbar');
  nav.classList.toggle('scrolled', window.scrollY > 40);
});

/* GSAP Parallax */
gsap.registerPlugin(ScrollTrigger, ScrollToPlugin);

gsap.timeline({
  scrollTrigger: {
    trigger: '.scrollDist',
    start: '0 0',
    end: '100% 100%',
    scrub: 1
  }
})
.fromTo('.cloud1',  { y: 100 },  { y: -800 }, 0)
.fromTo('.cloud2',  { y: -150 }, { y: -500 }, 0)
.fromTo('.cloud3',  { y: -50 },  { y: -650 }, 0)
.fromTo('.TreeBg',  { y: 0 },    { y: -200 }, 0)
.fromTo('.tree',    { y: -20 },  { y: -400 }, 0)
.fromTo('.Tree1',   { y: -30 },  { y: -350 }, 0);

ScrollTrigger.create({
  trigger: '#cards-section',
  start: 'top bottom',
  onEnter:     () => document.getElementById('parallax-scene').style.opacity = '0',
  onLeaveBack: () => document.getElementById('parallax-scene').style.opacity = '1'
});

const arrowBtn = document.querySelector('#arrow-btn');
if (arrowBtn) {
  arrowBtn.addEventListener('click', () => gsap.to(window, { scrollTo: innerHeight, duration: 1.5, ease: 'power1.inOut' }));
}

/* Vue 3D Cards */
Vue.component('card', {
  inheritAttrs: false,
  props: ['dataImage', 'link'],
  template: `
    <div class="card-wrap"
      @mousemove="handleMouseMove"
      @mouseenter="handleMouseEnter"
      @mouseleave="handleMouseLeave"
      @click="handleClick"
      ref="card"
      style="cursor: pointer;">
      <div class="card" :style="cardStyle">
        <div class="card-bg" :style="[cardBgTransform, cardBgImage]"></div>
        <div class="card-info">
          <slot name="header"></slot>
          <slot name="content"></slot>
        </div>
      </div>
    </div>`,
  mounted() {
    this.width  = this.$refs.card.offsetWidth;
    this.height = this.$refs.card.offsetHeight;
  },
  data: function() {
    return {
      width: 0,
      height: 0,
      mouseX: 0,
      mouseY: 0,
      mouseLeaveDelay: null
    };
  },
  computed: {
    mousePX: function() { return this.mouseX / this.width; },
    mousePY: function() { return this.mouseY / this.height; },
    cardStyle: function() {
      return { transform: 'rotateY(' + (this.mousePX * 30) + 'deg) rotateX(' + (this.mousePY * -30) + 'deg)' };
    },
    cardBgTransform: function() {
      return { transform: 'translateX(' + (this.mousePX * -40) + 'px) translateY(' + (this.mousePY * -40) + 'px)' };
    },
    cardBgImage: function() {
      return { backgroundImage: 'url(' + this.dataImage + ')' };
    }
  },
  methods: {
    handleMouseMove: function(e) {
      const rect = this.$refs.card.getBoundingClientRect();
      this.mouseX = e.clientX - rect.left - this.width  / 2;
      this.mouseY = e.clientY - rect.top  - this.height / 2;
    },
    handleMouseEnter: function() {
      clearTimeout(this.mouseLeaveDelay);
    },
    handleMouseLeave: function() {
      var self = this;
      this.mouseLeaveDelay = setTimeout(function() {
        self.mouseX = 0;
        self.mouseY = 0;
      }, 1000);
    },
    handleClick: function() {
      console.log('Card clicked, link prop:', this.link);
      if (this.link) {
        window.location.href = this.link;
      }
    }
  }
});

new Vue({ el: '#app' });

/* HOST EVENT MODAL - Logic */
const overlay      = document.getElementById('host-modal-overlay');
const modal        = document.getElementById('host-modal');
const openBtn      = document.getElementById('open-host-modal');
const closeBtn     = document.getElementById('modal-close');
const cancelBtn    = document.getElementById('modal-cancel');
const hostForm     = document.getElementById('host-form');
const formView     = document.getElementById('modal-form-view');
const successView  = document.getElementById('modal-success');
const globalError  = document.getElementById('form-global-error');
const successClose = document.getElementById('success-close');
const catSelect    = document.getElementById('f-cat');

/* Open / close */
function openModal() {
  document.body.style.overflow = 'hidden';
  overlay.classList.add('active');
  modal.scrollTop = 0;
}

function closeModal() {
  overlay.classList.remove('active');
  document.body.style.overflow = '';
  setTimeout(function() {
    formView.style.display    = '';
    successView.style.display = 'none';
    hostForm.reset();
    catSelect.classList.remove('sel-active');
    clearAllErrors();
    globalError.style.display = 'none';
  }, 400);
}

openBtn.addEventListener('click', openModal);
closeBtn.addEventListener('click', closeModal);
cancelBtn.addEventListener('click', closeModal);
successClose.addEventListener('click', closeModal);

overlay.addEventListener('click', function(e) {
  if (e.target === overlay) closeModal();
});

document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape' && overlay.classList.contains('active')) closeModal();
});

/* Keep select label floated */
catSelect.addEventListener('change', function() {
  catSelect.classList.toggle('sel-active', !!catSelect.value);
});

/* Validation helpers */
function markError(fieldEl, msg) {
  const wrap = fieldEl.closest('.form-field');
  wrap.classList.add('has-error');
  if (msg) wrap.querySelector('.field-error').textContent = msg;
}

function clearError(fieldEl) {
  fieldEl.closest('.form-field').classList.remove('has-error');
}

function clearAllErrors() {
  modal.querySelectorAll('.form-field.has-error').forEach(function(w) {
    w.classList.remove('has-error');
  });
}

function isEmail(v) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
}

/* Live clear on user interaction */
hostForm.querySelectorAll('input, select, textarea').forEach(function(el) {
  el.addEventListener('input',  function() { clearError(el); });
  el.addEventListener('change', function() { clearError(el); });
});

/* Submit */
hostForm.addEventListener('submit', function(e) {
  e.preventDefault();
  clearAllErrors();
  globalError.style.display = 'none';

  var g  = function(id) { return document.getElementById(id); };
  var ok = true;

  /* Required text/number fields */
  [
    ['f-fullname', 'Full name is required.'],
    ['f-phone',    'Phone number is required.'],
    ['f-org',      'Organization name is required.'],
    ['f-cid',      'ID number is required.'],
    ['f-title',    'Event title is required.'],
    ['f-location', 'Location is required.'],
    ['f-audience', 'Audience size is required.'],
    ['f-desc',     'Please describe your event.']
  ].forEach(function(item) {
    var id = item[0], msg = item[1];
    if (!g(id).value.trim()) { markError(g(id), msg); ok = false; }
  });

  /* Email */
  var emailEl = g('f-email');
  if (!emailEl.value.trim() || !isEmail(emailEl.value.trim())) {
    markError(emailEl, 'Enter a valid email address.');
    ok = false;
  }

  /* Category */
  if (!catSelect.value) {
    markError(catSelect, 'Please select a category.');
    ok = false;
  }

  /* Password */
  var pwEl  = g('f-pw');
  var cpwEl = g('f-cpw');
  if (pwEl.value.length < 8) {
    markError(pwEl, 'Password must be at least 8 characters.');
    ok = false;
  }
  if (cpwEl.value !== pwEl.value) {
    markError(cpwEl, 'Passwords do not match.');
    ok = false;
  }

  if (!ok) {
    globalError.style.display = 'block';
    var first = modal.querySelector('.form-field.has-error');
    if (first) first.scrollIntoView({ behavior: 'smooth', block: 'center' });
    return;
  }

  /* Success */
  formView.style.display    = 'none';
  successView.style.display = 'block';
  modal.scrollTop = 0;
});

/* Footer newsletter */
function handleSubscribe() {
  const input = document.getElementById('emailInput');
  const toast = document.getElementById('toast');
  toast.textContent = input.value && input.value.includes('@')
    ? "You're in! Watch your inbox."
    : 'Please enter a valid email.';
  input.value = '';
  toast.classList.add('show');
  setTimeout(() => toast.classList.remove('show'), 2500);
}