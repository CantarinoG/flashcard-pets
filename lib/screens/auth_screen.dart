import 'package:flashcard_pets/providers/services/firebase_auth_provider.dart';
import 'package:flashcard_pets/snackbars/success_snackbar.dart';
import 'package:flashcard_pets/themes/app_themes.dart';
import 'package:flashcard_pets/widgets/loading.dart';
import 'package:flashcard_pets/widgets/screen_layout.dart';
import 'package:flashcard_pets/widgets/text_field_wrapper.dart';
import 'package:flashcard_pets/widgets/themed_app_bar.dart';
import 'package:flashcard_pets/widgets/themed_filled_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String? errorMsg;
  bool _isLoading = false;

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

  void _forgotPassword() async {
    setState(() {
      errorMsg = null;
    });
    final String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        errorMsg = "Digite seu email primeiro para solicitar mudança de senha.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });
    final String? anyErrors =
        await Provider.of<FirebaseAuthProvider>(context, listen: false)
            .updatePasswordViaEmail(email);
    setState(() {
      _isLoading = false;
    });
    if (anyErrors != null) {
      setState(() {
        errorMsg = anyErrors;
      });
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const SuccessSnackbar(
            "Foi enviado um email para alterar a senha. Cheque seu email."),
        backgroundColor: Theme.of(context).colorScheme.bright,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _confirm(BuildContext context) async {
    setState(() {
      errorMsg = null;
    });
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmedPassword = _confirmPasswordController.text.trim();

    if (!_isDataValidated(email, password, confirmedPassword)) return;

    setState(() {
      _isLoading = true;
    });
    if (_isLogIn) {
      String? error =
          await Provider.of<FirebaseAuthProvider>(context, listen: false)
              .loginEmailPassword(email, password);
      setState(() {
        _isLoading = false;
      });
      if (error != null) {
        setState(() {
          errorMsg = error;
        });
      } else {
        Navigator.of(context).pop();
      }
    } else {
      String? error =
          await Provider.of<FirebaseAuthProvider>(context, listen: false)
              .createEmailPasswordAccount(email, password);
      setState(() {
        _isLoading = false;
      });
      if (error != null) {
        setState(() {
          errorMsg = error;
        });
      } else {
        Navigator.of(context).pop();
      }
    }
  }

  bool _isDataValidated(
      String email, String password, String confirmedPassword) {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMsg = "Email e senha são obrigatórios.";
      });
      return false;
    }

    if (password.length < 6) {
      setState(() {
        errorMsg = "A senha deve ter pelo menos 6 caracteres.";
      });
      return false;
    }

    if (!_isLogIn) {
      if (password != confirmedPassword) {
        setState(() {
          errorMsg = "As senhas são diferentes.";
        });
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? h1 = Theme.of(context).textTheme.headlineLarge;
    final TextStyle? body = Theme.of(context).textTheme.bodySmall;
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color secondary = Theme.of(context).colorScheme.secondary;
    final Color error = Theme.of(context).colorScheme.error;

    return Scaffold(
      appBar: const ThemedAppBar(""),
      body: ScreenLayout(
        child: SingleChildScrollView(
          child: _isLoading
              ? const Loading()
              : Column(
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
                            _isLogIn
                                ? "crie uma nova conta"
                                : "entre na sua conta",
                            style: body?.copyWith(
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
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
                        onPressed: _forgotPassword,
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
                    if (errorMsg != null)
                      Text(
                        errorMsg!,
                        style: body?.copyWith(color: error),
                      ),
                    const SizedBox(height: 8),
                    ThemedFilledButton(
                      label: _isLogIn ? "Entrar" : "Criar",
                      width: double.infinity,
                      onPressed: () {
                        _confirm(context);
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
