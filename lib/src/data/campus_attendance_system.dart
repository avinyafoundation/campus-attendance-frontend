import 'dart:developer';

import 'package:ShoolManagementSystem/src/data.dart';
import 'package:ShoolManagementSystem/src/data/activity_instance.dart';

final campusAttendanceSystemInstance = CampusAttendanceSystem()
  ..addBook(
      title: 'Left Hand of Darkness',
      authorName: 'Ursula K. Le Guin',
      isPopular: true,
      isNew: true)
  ..addBook(
      title: 'Too Like the Lightning',
      authorName: 'Ada Palmer',
      isPopular: false,
      isNew: true)
  ..addBook(
      title: 'Kindred',
      authorName: 'Octavia E. Butler',
      isPopular: true,
      isNew: false)
  ..addBook(
      title: 'The Lathe of Heaven',
      authorName: 'Ursula K. Le Guin',
      isPopular: false,
      isNew: false)
  ..setJWTSub('jwt-sub-id123')
  ..setUserPerson(
      Person(id: 2, jwt_sub_id: 'jwt-sub-id123', preferred_name: 'Nimal'))
  ..setCheckinActivityInstance(ActivityInstance(
    id: 1,
  ))
  ..setCheckoutActivityInstance(ActivityInstance(id: 11));

class CampusAttendanceSystem {
  final List<Book> allBooks = [];
  final List<Author> allAuthors = [];
  List<Employee>? allEmployees = [];
  List<AddressType>? addressTypes = [];
  List<Person>? persons = [];
  late Future<List<Vacancy>>? vacancies;
  List<AvinyaType>? avinyaTypes = [];
  Activity? activity;
  bool precondisionsSubmitted = false;
  bool applicationSubmitted = false;
  final String schoolName = 'Bandaragama';
  int vacancyId = 1; // todo - this needs to be fetched and set from the server
  Person userPerson = Person();
  Application application = Application();
  String? user_jwt_sub;
  String? user_jwt_email;
  ActivityInstance checkinActivityInstance = ActivityInstance();
  ActivityInstance checkoutActivityInstance = ActivityInstance();

  void setVacancyId(int id) {
    vacancyId = id;
  }

  int getVacancyId() {
    return vacancyId;
  }

  void setUserPerson(Person person) {
    userPerson = person;
  }

  Person getUserPerson() {
    return userPerson;
  }

  void setApplication(Application? application) {
    this.application = application!;
  }

  Application getApplication() {
    return this.application;
  }

  void setJWTSub(String? jwt_sub) {
    user_jwt_sub = jwt_sub;
  }

  String? getJWTSub() {
    return user_jwt_sub;
  }

  void setJWTEmail(String? jwt_email) {
    user_jwt_email = jwt_email;
  }

  String? getJWTEmail() {
    return user_jwt_email;
  }

  // void addEmployee(Employee employee) {
  //   allEmployees.add(employee);
  // }
  void setPrecondisionsSubmitted(bool value) {
    precondisionsSubmitted = value;
  }

  void setApplicationSubmitted(bool value) {
    applicationSubmitted = value;
  }

  bool getPrecondisionsSubmitted() {
    return precondisionsSubmitted;
  }

  bool getApplicationSubmitted() {
    return applicationSubmitted;
  }

  String getSchoolName() {
    return schoolName;
  }

  void setEmployees(List<Employee>? employees) {
    allEmployees = employees;
  }

  void setAddressTypes(List<AddressType>? addressTyples) {
    this.addressTypes = addressTyples;
  }

  void setPersons(List<Person>? persons) {
    this.persons = persons;
  }

  void setVacancies(Future<List<Vacancy>> vacancies) {
    this.vacancies = vacancies;
  }

  void setAvinyaTypes(List<AvinyaType>? avinyaTypes) {
    this.avinyaTypes = avinyaTypes;
  }

  void setActivity(Activity? activity) {
    this.activity = activity;
  }

  Future<List<Vacancy>>? getVacancies() {
    return vacancies;
  }

  void setCheckinActivityInstance(ActivityInstance? activityInstance) {
    this.checkinActivityInstance = activityInstance!;
  }

  void setCheckoutActivityInstance(ActivityInstance? activityInstance) {
    this.checkoutActivityInstance = activityInstance!;
  }

  ActivityInstance getCheckinActivityInstance() {
    return this.checkinActivityInstance;
  }

  ActivityInstance getCheckoutActivityInstance() {
    return this.checkoutActivityInstance;
  }

  void fetchPersonForUser() async {
    // check if user is in Avinya database person table as a student
    try {
      Person person = campusAttendanceSystemInstance.getUserPerson();
      if (person.jwt_sub_id == null ||
          person.jwt_sub_id != this.user_jwt_sub!) {
        person = await fetchPerson(this.user_jwt_sub!);
        this.userPerson = person;
        log('AdmissionSystem fetchPersonForUser: ' +
            person.toJson().toString());
      }
    } catch (e) {
      print(
          'AdmissionSystem fetchPersonForUser :: Error fetching person for user');
      print(e);
    }
  }

  void addPerson(Person person) {
    persons!.add(person);
  }

  void addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) {
    var author = allAuthors.firstWhere(
      (author) => author.name == authorName,
      orElse: () {
        final value = Author(allAuthors.length, authorName);
        allAuthors.add(value);
        return value;
      },
    );
    var book = Book(allBooks.length, title, isPopular, isNew, author);

    author.books.add(book);
    allBooks.add(book);
  }

  List<Book> get popularBooks => [
        ...allBooks.where((book) => book.isPopular),
      ];

  List<Book> get newBooks => [
        ...allBooks.where((book) => book.isNew),
      ];
}
