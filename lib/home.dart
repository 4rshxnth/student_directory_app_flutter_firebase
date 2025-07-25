import 'package:flutter/material.dart';
import 'package:student_directory_app/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0023E7),
        foregroundColor: Colors.white,
        title: Text(
          'Student Directory',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Add Student Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text('Name'),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: phonecontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text('Phone Number'),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: addresscontroller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        label: Text('Address'),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          screen(
                            name: namecontroller.text,
                            phone: phonecontroller.text,
                            address: addresscontroller.text,
                            context: context,
                          );
                        },
                        child: Text(
                          'Add Student',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0023E7),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: const Color(0xFF0023E7),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: fetchdata(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final studentdata = snapshot.data!.docs;
          return ListView.builder(
            itemCount: studentdata.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                  ],
                ),
                title: Text(studentdata[index]['Name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(studentdata[index]['Phone']),
                    Text(studentdata[index]['Address']),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
