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

`Scaffold 하위의 Center Widget 을 LoginForm 으로 Extract`

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

## MVVM 만들어 보기 

`flutter pub add provider`

```dart
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
      child: Scaffold(
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
      ),
    );
  }
}
```

```dart
class LoginViewModel extends ChangeNotifier {

}
```

## 입력에 따른 UI 내용 변경 
키보드 입력에 따라 X 버튼 노출 제어 
login 버튼 활성화 여부 제어 

```dart
class LoginViewModel extends ChangeNotifier {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String id = "";
  String password = "";

  LoginViewModel() {
    _idController.addListener(() {
      id = _idController.text;
      notifyListeners();
    });
    _passwordController.addListener(() {
      password = _passwordController.text;
      notifyListeners();
    });
  }

  void login() {

  }
}

```

```dart
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LoginViewModel>(context);   // <-- 요기 
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            ...,
            TextFormField(
              controller: viewModel._idController,          // <-- 요기 
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.account_circle),
                suffixIcon: viewModel.id.isNotEmpty          // <-- 요기
                    ? IconButton(
                        onPressed: () => viewModel._idController.clear(),
                        icon: const Icon(Icons.clear))
                    : null,
                
                ....
                  
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: viewModel._passwordController,          // <-- 요기
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password),
                suffixIcon: viewModel.password.isNotEmpty          // <-- 요기
                    ? IconButton(
                    onPressed: () => viewModel._passwordController.clear(),
                    icon: const Icon(Icons.clear))
                    : null,
                
                ....

              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: (viewModel.id.isNotEmpty && viewModel.password.isNotEmpty)          // <-- 요기
                        ? () => viewModel.login()
                        : null,
                    
                    ....
                    
                  ),
                ),
              ],
            ),
            
            ....
          
          ],
        ),
      ),
    );
  }
}

```

## 로그인 하는 느낌 주기 

```dart
class LoginViewModel extends ChangeNotifier {
  ....
      
  bool inProgress = false;

  Future<bool> login() async {
    inProgress = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    inProgress = false;
    notifyListeners();

    return id == 'aaa' && password == 'aaa';
  }
}
```

```dart
// LoginForm

void showLoginDialog(BuildContext context, bool success) {
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          success ? const Text("Success") : const Text("Fail"),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("close"),
          ),
        ],
      ),
    );
  });
}



```


```dart
  var enableLogin = viewModel.id.isNotEmpty && viewModel.password.isNotEmpty;

  ....

  FilledButton(
    onPressed: (enableLogin)
        ? () async {
            onSuccess() => showLoginDialog(context, true);
            onFail() => showLoginDialog(context, false);

            final success = await viewModel.login();
            if (success) {
              onSuccess();
            } else {
              onFail();
            }
          }
        : null,
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      side: const BorderSide(width: 1),
    ),
    child: const Text("Login"),
  )
```
