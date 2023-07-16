import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utility/api.dart';
import '../../utility/constants.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({Key? key}) : super(key: key);

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool isLoading=false;
  Future _clickButton(String type) async{
    if(type!="login") {
      _showError("Этот функционал пока не реализован.");
      return;
    }
    String login = _controllerLogin.text.trim();
    String password = _controllerPassword.text.trim();
    ////login="test@gmail.com";
    //password="thisisrlycoolpass";
    if( login.isEmpty || password.isEmpty) {
      _showError("Для входа в систему нужно указать Логин и пароль.");
      return;
    }
    else if( login.length<3 || password.length<3){
      _showError("Логин и пароль должны быть большее трех символов.");
      return;
    }
    setState(() {
      isLoading=true;
    });
    Map<String, dynamic>? data= await RestApi().request("auth/login", {"email":login,"password":password});
    if(data==null || data['error']!=null){
       if(data==null) {
         _showError("Система отказала в авторизации. Укажите правильный логин и пароль.");
         _controllerPassword.text="";
         _controllerLogin.text="";
        } else if(data['error']!=null) {
         _showError("Нет связи c сервером. Проверьте соединение и повторите попытку.");
       }
      setState(() {
        isLoading=false;
      });
      return;
    }
    Const.user['accessToken']=data['tokens']['accessToken'];
    Const.user['refreshToken']=data['tokens']['refreshToken'];
    Const.user['id']=data['user']['id'].toString();
    Const.user['email']=data['user']['email'];
    Const.user['nickname']=data['user']['nickname'];
    isLoading=false;
    if(mounted) Navigator.of(context, rootNavigator: false).pushNamed("/profile");
  }
  void _showError(String text){
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text("Внимание", style: TextStyle(fontSize: 18),),
          content:  Text(text, style: const TextStyle(fontSize: 14)),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("OK",style: TextStyle(fontSize: 18),),
              onPressed: ()=>  Navigator.of(context).pop(),
            )
          ],
        )
    );
  }
  Widget _button(String text, String type)=>Padding(
    padding: const EdgeInsets.fromLTRB(16,0,16,20),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 64,
            child: MaterialButton(
                onPressed: ()=>_clickButton(type),
                color:  const Color(0xFF4631d2),
                textColor: Colors.white,
                child: Text(text, style: const TextStyle(fontSize: 16),)),
          ),
        ),
      ],
    ),
  );
  Widget _loading()=>const Padding(
    padding: EdgeInsets.fromLTRB(16,0,16,20),
    child:SizedBox(
        height: 64*2+26,
        child: Center(child: CircularProgressIndicator(),))
  );
  TextFormField _input(String hintText,TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: controller==_controllerPassword,
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue.toString(),
      validator: (value) {  return null; },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Авторизация"),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _input("Логин или почта",_controllerLogin),
                  Container(
                    height: 1,
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(height: 1, color:const Color(0xFFccffff)),
                  ),
                  _input("Пароль",_controllerPassword),
                  const SizedBox(height: 30),
                  if(isLoading) _loading(),
                  if(!isLoading) _button("Войти","login"),
                  if(!isLoading) _button("Зарегистрироваться","registration"),
                ],
              ),
            ),
          ),
        )
    );
  }
}
