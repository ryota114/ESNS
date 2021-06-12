$(window).on('scroll', () => {
  $('.jscroll').jscroll({
    nextSelector: 'a.next',
    contentSelector: '.jscroll',
    autoTrigger: true
  });
});