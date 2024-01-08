import 'package:flutter/material.dart';
import 'package:project/presentation/login.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 250.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 393,
                  height: 311,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/0155/7b11/fc9dd2b402d3a90b43bafba48fced020?Expires=1705276800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lq5SAac0XtuS9b61wGXo6M3iu7xb7SZge-i-3a7PqxM70l5-~lolwwbSF-xJjD~Q2xgJW~z3BrAT46rv4lAA6AanBMgKnMj~9PLlv5URSjrBwLN6b~EHaBJgPpVS0BxmvssrfKCJdKYlSLjp0NX~MDQ41VJgdK4~M54Rn40L9-vD5AvzWkkVIpVhDs-k9W4ka9hy0hga4n1Y8h1sGP9V6d15DIITJz5OkkJSPnsMT-SEaPsnpvamcPVDxjSxFF54W5~Y-7APL5VsH0gu~EE-o97k3IcYYMchg49n1F4M3TIvy2VjlqvcIlPAmcObSKDOFCJ6tcpB-Xfsg5K3loBq4Q__"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'AZA',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'AZA Sportive Event Planner',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginPageUser(isOrganizer: false)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text('Continue as user',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginPageUser(isOrganizer: true)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  child: Text('Continue as organizer',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      )),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Text(
                    'copyright@2023 AZA',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
