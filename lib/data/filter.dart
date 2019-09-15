class Filter {
  List<String> _contacts = new List<String>();
  DateTime _to, _from;

  Filter() {
    _to = new DateTime.now();
    _from = new DateTime.now().subtract(new Duration(days: 30));
  }
  
  get contacts => _contacts;

  get to => _to;

  get from => _from;

  setFrom(DateTime date) => _from = date;

  setTo(DateTime date) => _to = date;

  addContact(String contact) => _contacts.add(contact);

  removeContact(String contact) => _contacts.remove(contact);
}
