$(window).on('scroll', () => {
  $('.jscroll').jscroll({
    nextSelector: 'a.next',
    contentSelector: '.next-jscroll',
    autoTrigger: true
  });
});