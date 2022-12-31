class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final email = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("User login"),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),
                    child: TextField(
                        controller: email,
                        minLines: 1,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.indigo,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                          prefixIcon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                          hintText: 'Event',
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 12),

                    child: TextField(

                        controller: password,
                        minLines: 1,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.indigo,
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)),
                          prefixIcon: const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                          hintText: 'Event',
                        )),
                  ),
                  ElevatedButton(onPressed: () async {
                    String a = email.text;
                    String b = password.text;
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(

                        email: a,
                        password: b,
                      );
                    }
                    on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        if (kDebugMode) {
                          print('The password provided is too weak.');
                        }
                      } else if (e.code == 'email-already-in-use') {
                        const AlertDialog(
                          title: Text("user exists"),
                        );
                        if (kDebugMode) {
                          print('The account already exists for that email.');
                        }
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    } },
                    child: const Text("Sign up"),
                  ),
                  ElevatedButton(onPressed: () {
                    Future <void> googleSignIn() async {
                      final googleAccount = await GoogleSignIn().signIn();
                      if (googleAccount != null) {
                        final googleAuth = await googleAccount.authentication;
                        if (googleAuth.accessToken != null &&
                            googleAuth.idToken != null) {
                          try {
                            final name = googleAccount.displayName;
                            final imageUrl = googleAccount.photoUrl;

                            final email = googleAccount.email;
                            await FirebaseAuth.instance.signInWithCredential(

                              GoogleAuthProvider.credential(

                                accessToken: googleAuth.accessToken,
                                idToken: googleAuth.idToken,

                              ),
                            );
                          } on FirebaseException catch (error) {
                            // print(error.message);

                          } catch (error) {
                            //handle error
                          };
                        }
                      }}
                  },
                    child: const Text("Sign in"),
                  )
                ]
            )
        )
    );
  }
}