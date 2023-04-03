## START!
```dart
//main.dart
import 'package:flutter/material.dart';

import 'color_schemes.g.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Video Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
```

`
머티리얼 테마 컬러 만들기 : {https://m3.material.io/theme-builder#/dynamic}
`

## 로그인 폼 만들기 
```dart
//main.dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Spacer(),
              const Text(
                'Lorem Ipsum',
                style: TextStyle(fontSize: 40),
              ),
              const Spacer(),
              TextFormField(),
              const SizedBox(height: 8),
              TextFormField(),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Create an account.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
### 입력창 꾸미기 
```dart
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Lorem Ipsum',
              style: TextStyle(fontSize: 40),
            ),
            const Spacer(),
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                ),
                hintText: "User name",
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                ),
                hintText: "Password",
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                      side: const BorderSide(width: 1),
                    ),
                    child: const Text("Login"),
                  ),
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text('Create an account.'),
            ),
          ],
        ),
      ),
    ),
  );
}


```

## 리소스 추가 + 디자인 작업
assets 디렉토리를 만들고 그 하위에 images, fonts 디렉토리를 각각 만든다. 
`
```
>  Project   
    > assets  
        > fonts  
        > images     
```

```yaml
# pubspec.yaml
  assets:
    - assets/images

  fonts:
    - family: Woodshop
      fonts:
        - asset: assets/fonts/Woodshop-Regular.otf
```

> Scaffold 하위의 Center Widget 을 LoginForm 으로 Extract

```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/login_bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
          const LoginForm(),
        ],
      ),
    );
  }
}
```

```dart
            const Text(
              'Lorem Ipsum',
              style: TextStyle(fontSize: 40, fontFamily: 'Woodshop'),
            ),
```

