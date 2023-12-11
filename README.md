# Firebase-authentication

This project is an example of Firebase authentication in a flutter.
This project shows how to implement a full authentication flow in Flutter, using Email.Password and Google authentication.

It aims to be a reference implementation. Think of it as "authentication done right".

## Project goals
This project shows how to:

- Sign up with an email and password
- Sign in with that email and password
- Verify email
- Reset password
- Sign up with Google authentication
- Sign in with Google authentication
- Use appropriate state management techniques to separate UI, logic, and Firebase authentication code
- Handle errors and present user-friendly error messages
- Write production-ready code following best practices

Feel free to use this in your own projects. 😉
```bash
NOTE: This project will be kept up to date with the latest packages and Flutter version._
```

## Firebase Configuration
- Follow [Firebase documentation](https://firebase.google.com/docs/auth/flutter/start) to configure Firebase SDK
- For Google authentication follow [these instructions](https://developers.google.com/android/guides/client-auth) to add your app SHA1 fingerprint to Firebase


## Platforms supported
- ✔ Android
- ✔ web
- ❌ windows

## Preview
**Sign-in** 
<br/><br/>
<img src="preview/signin.gif" height="600px" width="300px">

**Sign-up** 
<br/><br/>
<img src="preview/signup.gif" height="600px" width="300px">

**Forgot password** 
<br/><br/>
<img src="preview/forgot.gif" height="600px" width="300px">
<br/>

**Sign-in**

![](preview/signin.png)

**Sign-Up**

![](preview/signup.png)


**Forgot-Password**

![](preview/forgot.png)

**Home**

![](preview/homepage.png)

## Features and Plugins used
- ✔ Null safety
- ✔ Firebase
- ✔ firebase_core
- ✔ firebase_auth1
- ✔ provider


### Authentication features

- ✔ Email & Password Sign In
- ✔ Email & Password Sign Up
- ✔ Reset Password
- ✔ Verify Email
- ✔ Google authenticaton

## Application features

### Choose provider page

- ✔ Select between email/password and Google authnticaton

### Sign-in Page

- ✔ Form to enter email and password for signing-in the user.
- ✔ Button to toggle sign-up view.
- ✔ Button to navigate to forgot password page.

### Sign-up Page

- ✔ Form to enter a name, email, and password for signing up the user.
- ✔ Button to toggle sign-in view.

### Forgot Password Page

- ✔ Form to enter email for resetting the password.
- ✔ Button to navigate to the sign-in page.


### Features to add
- Mobile number authentication 
- signin/signup via facebook
- signin/signup using twitter 
- signin/signup using github

#### Made with ❤ by [@nittinsharma37](https://github.com/nittinsharma37)
## License
[MIT](https://choosealicense.com/licenses/mit/)
