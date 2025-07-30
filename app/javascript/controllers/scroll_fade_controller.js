import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.onScroll = this.onScroll.bind(this);
    window.addEventListener('scroll', this.onScroll);
    this.onScroll();
  }

  disconnect() {
    window.removeEventListener('scroll', this.onScroll);
  }

  onScroll() {
    const fadeElements = document.querySelectorAll('.fade-in-element');

    fadeElements.forEach(element => {
      const elementTop = element.getBoundingClientRect().top;
      const viewportHeight = window.innerHeight;

      if (elementTop < viewportHeight - 150) {
        element.classList.add('opacity-100');
        element.classList.remove('opacity-0');
      } else {
        element.classList.remove('opacity-100');
        element.classList.add('opacity-0');
      }
    });
  }
}
