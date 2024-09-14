import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final bool isLogIn;
  const AuthScreen({this.isLogIn = true, super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool _isLogIn;
  bool _obscurePassText = true;
  bool _obscureConfirmedPassText = true;

  // TextEditingControllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLogIn = widget.isLogIn;
  }

  @override
  void dispose() {
    // Dispose of the controllers
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleAuthAction() {
    setState(() {
      _isLogIn = !_isLogIn;
    });
  }

  void _togglePassVisibility() {
    setState(() {
      _obscurePassText = !_obscurePassText;
    });
  }

  void _toggleConfirmedPassVisibility() {
    setState(() {
      _obscureConfirmedPassText = !_obscureConfirmedPassText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h1 = Theme.of(context).textTheme.headlineLarge;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;

    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: const ThemedAppBar(""),
      body: ScreenLayout(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isLogIn ? "Entre na sua conta" : "Crie uma nova conta",
              style: h1?.copyWith(color: secondary),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ou ",
                  style: body,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: _toggleAuthAction,
                  child: Text(
                    _isLogIn ? "crie uma nova conta" : "entre na sua conta",
                    style: body?.copyWith(
                      color: primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (!_isLogIn)
              TextFieldWrapper(
                label: "Nome",
                child: TextField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    errorText: null,
                  ),
                ),
              ),
            if (!_isLogIn)
              TextFieldWrapper(
                label: "Nome de Usuário",
                child: TextField(
                  controller: _usernameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    prefixText: "@",
                    border: InputBorder.none,
                    errorText: null,
                  ),
                ),
              ),
            TextFieldWrapper(
              label: "Email",
              child: TextField(
                controller: _emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  errorText: null,
                ),
              ),
            ),
            TextFieldWrapper(
              label: "Senha",
              child: TextField(
                controller: _passwordController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscurePassText,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: primary,
                    ),
                    onPressed: _togglePassVisibility,
                  ),
                ),
              ),
            ),
            if (!_isLogIn)
              TextFieldWrapper(
                label: "Confirmar Senha",
                child: TextField(
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _obscureConfirmedPassText,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorText: null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmedPassText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: primary,
                      ),
                      onPressed: _toggleConfirmedPassVisibility,
                    ),
                  ),
                ),
              ),
            if (_isLogIn)
              TextButton(
                onPressed: () {},
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Esqueceu sua senha?",
                    style: body?.copyWith(
                      color: primary,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            ThemedFilledButton(
              label: _isLogIn ? "Entrar" : "Criar",
              width: double.infinity,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
