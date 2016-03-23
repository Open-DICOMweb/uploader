//TODO: add copyright
library acr.client.user;


class User {
  final int id;
  final String name;
  final List<Site> sites;

  const User(this.id, this.name, this.sites);

  static const philbin = const User(1, "jfphilbin",
      const [Site.hopkinsBayview, Site.hopkinsEast, Site.hopkinsSuburban]);

  static const wang = const User(1, "twang",
      const [Site.columbiaWest, Site.dukeDurham]);

  static const List<Site> users = const [philbin, wang];

  static List<String> names =  [philbin.name, wang.name];
}

class Site {
  final int id;
  final String name;
  final System system;
  //TODO: add other fields

  const Site(this.id, this.name, this.system);

  static const columbiaWest = const Site(1, "Columbia West Side", System.columbia);
  static const dukeDurham = const Site(2, "Duke Durham", System.duke);
  static const hopkinsEast= const Site(3, "Johns Hopkins East Baltimore", System.hopkins);
  static const hopkinsBayview = const Site(4, "Johns Hopkins Bayview", System.hopkins);
  static const hopkinsSuburban = const Site(5, "Johns Hopkins Suburban", System.hopkins);

  static const List<Site> sites = const [
    columbiaWest,
    dukeDurham,
    hopkinsBayview,
    hopkinsEast,
    hopkinsSuburban
  ];

  static List<String> names =  [
    columbiaWest.name,
    dukeDurham.name,
    hopkinsBayview.name,
    hopkinsEast.name,
    hopkinsSuburban.name
  ];
}
class System {
  final int id;
  final String name;
  //TODO: define rest of fields

  const System(this.id, this.name);

  static const columbia = const System(1, "Columbia-Presbyterian");
  static const duke = const System(2, "Duke Health System");
  static const hopkins = const System(3, "Johns Hopkins");
  static const penn = const System(4, "Univ of Pennsylvania");
  static const yale = const System(5, "Yale University Health System");

  static const List<System> systems = const [
    columbia, duke, hopkins, penn, yale
  ];

  static List<String> names = [
    columbia.name,
    duke.name,
    hopkins.name,
    penn.name,
    yale.name
  ];
}

class Trial {
  final int id;
  final String name;
  //TODO: add other fields

  const Trial(this.id, this.name);

  static const trial1 = const Trial(1, "Trial 1");
  static const trial2 = const Trial(2, "Trial 2");
  static const trial3 = const Trial(3, "Trial 3");
  static const trial4 = const Trial(4, "Trial 4");
  static const trial5 = const Trial(5, "Trial 5");

  static const List<Site> trials = const [
    trial1,
    trial2,
    trial3,
    trial4,
    trial5
  ];

  static List<String> names =  [
    trial1.name,
    trial2.name,
    trial3.name,
    trial4.name,
    trial5.name
  ];
}
class Subject {
  final int id;
  final String name;
  //TODO: add other fields

  const Subject(this.id, this.name);

  static const subject1 = const Subject(1, "Subject 1");
  static const subject2 = const Subject(2, "Subject 2");
  static const subject3 = const Subject(3, "Subject 3");
  static const subject4 = const Subject(4, "Subject 4");
  static const subject5 = const Subject(5, "Subject 5");

  static const List<Site> trials = const [
    subject1,
    subject2,
    subject3,
    subject4,
    subject5
  ];

  static List<String> names =  [
    subject1.name,
    subject2.name,
    subject3.name,
    subject4.name,
    subject5.name
  ];
}

class Step {
  final int id;
  final String name;
  //TODO: add other fields

  const Step(this.id, this.name);

  static const step1 = const Step(1, "step 1");
  static const step2 = const Step(2, "step 2");
  static const step3 = const Step(3, "step 3");
  static const step4 = const Step(4, "step 4");
  static const step5 = const Step(5, "step 5");

  static const List<Site> trials = const [
    step1,
    step2,
    step3,
    step4,
    step5
  ];

  static List<String> names =  [
    step1.name,
    step2.name,
    step3.name,
    step4.name,
    step5.name
  ];
}

class Program {
  final int id;
  final String name;
  //TODO: add other fields

  const Program(this.id, this.name);

  static const program1 = const Program(1, "Program 1");
  static const program2 = const Program(2, "Program 2");
  static const program3 = const Program(3, "Program 3");
  static const program4 = const Program(4, "Program 4");
  static const program5 = const Program(5, "Program 5");

  static const List<Site> trials = const [
    program1,
    program2,
    program3,
    program4,
    program5
  ];

  static List<String> names =  [
    program1.name,
    program2.name,
    program3.name,
    program4.name,
    program5.name
  ];
}

