import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

/*
* Author: Gilbert M. Oca
* Last Update : May 2023
* Description : This app can be used for registration
* of participants in seminars, symposium, colloquium,
* conferences, and other events.
* Once the "Register" button is clicked, the current
* information is appended in the list.
* In the AppBar menu button, users can email the list
* as a text file.
* */
void main() => runApp(MyRegApp());

class MyRegApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String dropdownValue = 'do_nothing';

  // this object must be inside a stateful widget so that flutter
  // will handle the changes
  TextEditingController nameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController mobileTEC = TextEditingController();
  TextEditingController affiliationTEC = TextEditingController();
  TextEditingController roleTEC = TextEditingController();

  void clearTextFields() {
    nameTEC.clear();
    emailTEC.clear();
    mobileTEC.clear();
    affiliationTEC.clear();
    roleTEC.clear();
  }

  Future<dynamic> displayList(name_list) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Registration List"),
        content: SingleChildScrollView(child: Text(name_list)),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: name_list));
              Navigator.of(ctx).pop();
            },
            child: Text("Copy to Clipboard"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Future<dynamic> emailList(prefs) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Launch Email"),
        content: Text("This feature is under construction"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<dynamic> clearList() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("List has been deleted"),
        content: Text("You may now create a new list.!"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        //leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        actions: [
          DropdownButton(
            icon: Icon(Icons.menu),
            onChanged: (String? newValue) async {
              setState(() {
                dropdownValue = newValue!;
              });
              SharedPreferences prefs = await SharedPreferences.getInstance();
              //prefs.setString('reg_data', reg_datum);
              if (newValue == 'View List') {
                var name_list = prefs.getString('reg_data');
                if (name_list == null) {
                  name_list = "List is empty.";
                }
                displayList(name_list);
              } else if (newValue == 'Email List') {
                var name_list = prefs.getString('reg_data');
                emailList(name_list);
              } else if (newValue == 'Clear List') {
                prefs.remove('reg_data');
                clearList();
              } else {
                // do nothing
              }
            },
            items: <String>['View List', 'Email List', 'Clear List']
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ],
        centerTitle: true,
        title: Text('I M S P'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'images/research_group_logo.png',
                  width: 60.0,
                ),
                Text(
                  "Applied Spectroscopy Research Group \n presents",
                  textAlign: TextAlign.center,
                ),
                Text(""),
                Text(
                  "2nd Biomedical Physics \n Seminar and Workshop",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
                ),
                Text(""),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameTEC,
                    keyboardType: TextInputType.name,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    //decoration property
                    decoration: InputDecoration(
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.person_outline_rounded,
                        color: Colors.grey,
                      ),
                      focusColor: Colors.white,
                      // hintText: "Surname, Name",
                      fillColor: Colors.grey,
                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //create lable
                      labelText: 'Name  M.I.  Surname',
                      //label style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    //decoration property
                    decoration: InputDecoration(
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.mail_outline_outlined,
                        color: Colors.grey,
                      ),
                      focusColor: Colors.white,
                      // hintText: "Email",
                      fillColor: Colors.grey,
                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //create lable
                      labelText: 'Email',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: mobileTEC,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    //decoration property
                    decoration: InputDecoration(
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.mobile_friendly,
                        color: Colors.grey,
                      ),
                      focusColor: Colors.white,
                      // hintText: "Mobile Number",
                      fillColor: Colors.grey,
                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //create lable
                      labelText: 'Mobile Number',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: affiliationTEC,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    //decoration property
                    decoration: InputDecoration(
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.account_balance_outlined,
                        color: Colors.grey,
                      ),
                      focusColor: Colors.white,
                      // hintText: "Affiliation",
                      fillColor: Colors.grey,
                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //create label
                      labelText: 'Affiliation, e.g. IMSP, UPLB',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    autofocus: true,
                    controller: roleTEC,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    //decoration property
                    decoration: InputDecoration(
                      //add prefix icon
                      prefixIcon: Icon(
                        Icons.accessibility_new_outlined,
                        color: Colors.grey,
                      ),
                      focusColor: Colors.white,
                      // hintText: "Role",
                      fillColor: Colors.grey,
                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //create label
                      labelText:
                          'Role, e.g. Student | Teacher | Researcher | etc.',
                      //lable style
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Text(""),
                TextButton(
                  onPressed: () async {
                    print("Hello World!");
                    var _name = nameTEC.text;
                    var _email = emailTEC.text;
                    var _mobile = mobileTEC.text;
                    var _affiliation = affiliationTEC.text;
                    var _role = roleTEC.text;
                    // convert data into comma separated values
                    var reg_datum = _name +
                        ',' +
                        _email +
                        ',' +
                        _mobile +
                        ',' +
                        _affiliation +
                        ',' +
                        _role +
                        '\n';
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var previous_list = prefs.getString('reg_data');
                    if (previous_list == null) {
                      previous_list = '';
                    }
                    var appended_list = "$previous_list\n$reg_datum";
                    prefs.setString('reg_data', appended_list);
                    clearTextFields();
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text("Thank you"),
                        content: Text("Registration is saved!"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.cyan),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
