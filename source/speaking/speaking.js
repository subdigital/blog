// remember in Yavascript that months are 0-indexed
var events = [
  { name: 'Guest Lecture @ The Iron Yard', url: 'https://www.theironyard.com/locations/houston.html?_ga=1.237302848.1734697495.1484928607', startDate: new Date(2016, 9, 27), location: 'Houston, TX'},
  { name: 'San Antonio iOS Meetup', url: 'https://www.meetup.com/San-Antonio-iOS-Developer-Meetup/', startDate: new Date(2016, 10, 9) },
  { name: 'Pragma Conference', url: 'http://pragmaconference.com/', startDate: new Date(2016, 9, 12), endDate: new Date(2016, 9, 14), location: 'Verona, Italy'},
  { name: 'CocoaConf DC', url: 'http://cocoaconf.com/dc-2015/home', startDate: new Date(2016, 3, 10), endDate: new Date(2016, 3, 11), location: 'Washington, DC'},
  { name: 'CocoaConf Portland', url: "http://cocoaconf.com/portland-2015/home", startDate: new Date(2015, 4, 8), location: "Portland, OR" },
  { name: 'CocoaConf Atlanta 2014', url: "http://cocoaconf.com/atlanta-2014/home", startDate: new Date(2014, 11, 5), location: "Atlanta, GA" },
  { name: 'CocoaConf Boston 2014', url: "http://cocoaconf.com/boston-2014/home", startDate: new Date(2014, 10, 14), location: "Boston, MA" },
  { name: 'Pragma Mark', url: "http://pragmamark.org/events/pragma-conference-2014/", startDate: new Date(2014, 9, 4), location: 'Milan, Italy'},
  { name: 'YOW! Connected', url: "http://connected.yowconference.com.au", startDate: new Date(2014, 8, 20), location: 'Melbourne, Australia' },
  { name: 'Houston iOS Meetup', startDate: new Date(2014, 5, 17), location: 'Houston, TX' },
  { name: 'Philly Emerging Tech 2014', url: 'http://phillyemergingtech.com/2014', startDate: new Date(2014, 3, 22), location: 'Philidelphia, PA'},
  { name: 'CocoaConf Boston', url: 'http://cocoaconf.com/boston-2013/home', startDate: new Date(2013, 9, 25), location: 'Boston, MA'},
  { name: 'Mobile Developer Summit', url: 'http://www.developermarch.com/mds/', startDate: new Date(2013, 9, 5), location: 'Bangalore, India' },
  { name: 'CocoaConf Portland', url: 'http://cocoaconf.com/portland-2013/home', startDate: new Date(2013, 7, 15), location: 'Portland, OR' },
  { name: 'CocoaConf Dallas', url: 'http://cocoaconf.com/dallas-2013/home', startDate: new Date(2013, 3, 4), location: 'Dallas, TX' },
  { name: 'CocoaConf Chicago (March 2013)' },
  { name: 'Mdevcon (March 2013, Amsterdam)' },
  { name: 'DevTeach Vancouver (May 2011)' },
  { name: 'Houston Tech Fest (October 15th, 2011)' },
  { name: 'Houston Code Camp 2011 (August 20th, 2011)' },
  { name: 'Lone Star Ruby Conference (August 16th, 2011)' },
  { name: 'Houston iPhone Developer’s Meetup (July 2011)' },
  { name: 'Phone Dev Con – Boston, MA (April 4-6, 2011)' },
  { name: 'Lone Star Ruby Conference – Austin, TX (August 26-28th 2010)' },
  { name: 'iPhone/iPad Dev Con – San Diego, CA (September 27-29 2010)' },
  { name: 'Houston Tech Fest – Houston, TX (October 9, 2010)' }
];

new Vue({
  el: '#speaking',
  data: {
    events: events
  },
  mounted: function() {
    console.log(events);
  },
  methods: {
  },
  computed: {
    upcomingEvents: function() {
      var upcoming = [];
      for (var i = 0; i<self.events.length; i++) {
        var event = self.events[i];
        if (event.startDate && event.startDate.getTime() >= new Date().getTime()) {
          upcoming.push(event);
        }
      }
      return upcoming;
    },
    pastEvents: function() {
      var past = [];
      for (var i = 0; i<self.events.length; i++) {
        var event = self.events[i];
        if (event.startDate == undefined || event.startDate.getTime() < new Date().getTime()) {
          past.push(event);
        }
      }
      return past;
    }
  },
  components: {
    eventListItem: {
      template: '#event-list-item-template',
      props: ['event'],
      methods: {
        formatDate: function(date) {
          var monthNames = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];
          var day = date.getDate();
          var monthIndex = date.getMonth();
          var dateString = monthNames[date.getMonth()] + ' ' + day
          if (date.getTime() < new Date().getTime()) {
            // in the past, use full year
            var year = date.getFullYear();
            dateString +=  ', ' + year;
          }
          return dateString;
        }
      }
    }
  }
});
