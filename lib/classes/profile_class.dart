class Profile {
  String name; // the name of the person
  String image; // the location of the profile image
  List<int> tournamentYears = []; // years when won the tournament
  List<int> secondYears =[]; // years with second place
  List<int> thirdYears = []; // years with third place
  List<int> bracketYears = []; // years when won the bracket
  List<int> roundsYears; // years when won the 'rounds'

  Profile({this.name, this.image, this.tournamentYears, this.secondYears,
    this.thirdYears, this.bracketYears, this.roundsYears});
}

Profile ale = Profile(name: 'Ale', image: 'ale.jpg', tournamentYears: [2018], secondYears: [2017,2020],
    thirdYears: [], bracketYears: [2017,2018,2020], roundsYears: [2018]);
Profile enrico = Profile(name: 'Enrico', image: 'enrico.jpg', tournamentYears: [], secondYears: [],
    thirdYears: [2019], bracketYears: [], roundsYears: []);
Profile fabio = Profile(name: 'Fabio', image: 'fabio.jpg', tournamentYears: [], secondYears: [],
    thirdYears: [2017], bracketYears: [2017], roundsYears: []);
Profile luca = Profile(name: 'Luca', image: 'luca.jpg', tournamentYears: [], secondYears: [2019],
    thirdYears: [], bracketYears: [2019], roundsYears: []);
Profile magu = Profile(name: 'Magu', image: 'gianluca.jpg', tournamentYears: [2016], secondYears: [2018],
    thirdYears: [2020], bracketYears: [2016,2017,2018], roundsYears: []);
Profile melo = Profile(name: 'Melo', image: 'melo.jpg', tournamentYears: [2017, 2019], secondYears: [],
    thirdYears: [2018], bracketYears: [2017], roundsYears: [2017,2019]);
Profile nic = Profile(name: 'Nic', image: 'nic.jpg', tournamentYears: [], secondYears: [2016],
    thirdYears: [], bracketYears: [], roundsYears: [2016,2020]);
Profile teo = Profile(name: 'Teo', image: 'teo.jpg', tournamentYears: [2020], secondYears: [2016],
    thirdYears: [], bracketYears: [2020], roundsYears: []);
Profile yiwei = Profile(name: 'Yiwei', image: 'yiwei.jpg', tournamentYears: [], secondYears: [],
    thirdYears: [], bracketYears: [], roundsYears: []);

Profile admin = Profile(name: 'Admin', image: 'nba.jpg');

List<Profile> profiles = [ale, enrico, fabio, luca, magu, melo, nic, teo, yiwei];
