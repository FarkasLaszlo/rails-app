document.addEventListener('turbolinks:visit', () => {
  if(/\/comments\/[0-9]+\/new/.test(window.location.href) || /\/comments\/[0-9]+\/edit/.test(window.location.href)){
    blog_id = window.location.href.match(/\?blog_id=([0-9]+)/)[1];
    history.replaceState('', '', window.location.href.match(/(.*)\?/)[1]);
  }
})
