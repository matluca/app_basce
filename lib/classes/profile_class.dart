class Profile {
  String name; // the name of the person
  String image; // the location of the profile image
  List<int> tournamentYears = []; // years when won the tournament
  List<int> secondYears = []; // years with second place
  List<int> thirdYears = []; // years with third place
  List<int> bracketYears = []; // years when won the bracket
  List<int> roundsYears = []; // years when won the 'rounds'

  Profile(this.name, this.image, this.tournamentYears, this.secondYears,
      this.thirdYears, this.bracketYears, this.roundsYears);
}

Profile ale = Profile(
    'Ale', 'ale.jpg', [2018], [2017, 2020], [2025], [2017, 2018, 2020], [2018, 2025]);
Profile enrico = Profile('Enrico', 'enrico.jpg', [2025], [2023], [2019, 2022], [2025], []);
Profile fabio =
    Profile('Fabio', 'fabio.jpg', [], [], [2017, 2021], [2017, 2021], []);
Profile luca = Profile('Luca', 'luca.jpg', [2021], [2019], [], [2019], []);
Profile magu = Profile(
    'Magu', 'gianluca.jpg', [2016], [2018, 2025], [2020, 2024], [2016, 2017, 2018], []);
Profile melo = Profile('Melo', 'melo.jpg', [2017, 2019], [2022, 2024], [2018],
    [2017, 2021], [2017, 2019, 2022, 2023]);
Profile nic =
    Profile('Nic', 'nic.jpg', [2022, 2024], [2016], [], [2022, 2024], [2016, 2020, 2024]);
Profile teo =
    Profile('Teo', 'teo.jpg', [2020, 2023], [2016, 2021], [], [2020, 2023], [2021, 2025]);
Profile yiwei = Profile('Yiwei', 'yiwei.jpg', [], [], [], [], []);

Profile admin = Profile('Admin', 'nba.jpg', [], [], [], [], []);

List<Profile> profiles = [
  ale,
  enrico,
  fabio,
  luca,
  magu,
  melo,
  nic,
  teo,
  yiwei
];
