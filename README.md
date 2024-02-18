# Hakaity App
Application of children's stories to teach children to read


## Overview
The application contains list of products such as shoes, slippers on which user can click to view its details and then, add them to cart. User can like and dislike the product as well. Also, User can sell products, if he/she signed up as a Seller.
Some other features are as following:
- Login / Signup .
- The child can review the story.
- Search for any story.
- The child can listen to the story.
- The child can record his voice while reading the story.
- The application verifies that the child is reading the story correctly.
- One of parants can change the settings.
- View detailed reports and statistics about stories.
- View progress.




## Some Screenshots

|             Splash Screen            |             Application Home              |           Product Detail            |
| :----------------------------------: | :---------------------------------------: | :----------------------------------:|
| [![](snapshots/shopping-launcher.png)](https://github.com/MaryamHajeb/Graduation-Project/blob/main/ScreenShots/NameChiled.jpg) | ![](snapshots/shopping-home-customer.png) | ![](snapshots/shopping-product.png) |

|                 Signup              |                Login              |        OTP Verification         |
| :---------------------------------: | :-------------------------------: | :------------------------------:|
| ![](snapshots/shopping-sign-up.png) | ![](snapshots/shopping-login.png) | ![](snapshots/shopping-otp.png) |

|           Shopping Cart          |             Address Selection              |             Payment Method             |               Order Success               |
| :------------------------------: | :----------------------------------------: | :-------------------------------------:| :---------------------------------------: |
| ![](snapshots/shopping-cart.png) | ![](snapshots/shopping-select-address.png) | ![](snapshots/shopping-choose-pay.png) | ![](snapshots/shopping-order-success.png) |

|               Add Product               |             All Orders             |                Order Detail              |               Sign Out               |
| :-------------------------------------: | :--------------------------------: | :---------------------------------------:| :----------------------------------: |
| ![](snapshots/shopping-add-product.png) | ![](snapshots/shopping-orders.png) | ![](snapshots/shopping-order-detail.png) | ![](snapshots/shopping-sign-out.png) |

## Project Setup

### Clone and install

Clone this repository and import into Android Studio
```
git clone https://github.com/i-vishi/shopping-android-app.git
```

### Configuration
- The project requires Firebase. So follow the steps given [here (Add Firebase to Android Project)](https://firebase.google.com/docs/android/setup) to add firebase to your android project.
- Download the firebase config file `google-services.json`
- Move the config file to `(app)` module of the project.
- Also, add Cloud Firestore for storing users, products, orders and addresses data. Follow instructions [here (Add Cloud Firestore to your app)](https://firebase.google.com/docs/firestore/quickstart) to add Cloud Firestore to your app.
- There need to be two collections - `users` for Users data and `products` for Products Data.
- This project also, requires OTP based authentication. So, you just need to enable Phone Number sign-in in your firebase project. Follow instructions [here (Enable Phone Number sign-in)](https://firebase.google.com/docs/auth/android/phone-auth) to enable Phone Number sign-in. 
- Do not forget to enable app verification for your firebase project. Follow instructions [here (Enable app verification)](https://firebase.google.com/docs/auth/android/phone-auth#enable-app-verification) to enable app verification. Add both SHA-1 and SHA-256 fingerprints.

Tried everything but still not able to explore the app due to OTP errors? Don't worry, you can by-pass the OTP screen and explore the app.
- Go to `app/src/main/java/com/vishalgaur/shoppingapp/Utils.kt` file.
- Change the return value for function `shouldBypassOTPValidation()` to `true`.
- You are good to go now. Just run the app and explore.
- And take your time to setup the OTP verification. :wink:

## Built With
- Flutter
- Bloc State Management
- Sqlflite
- google_speech package 
- Google Speech to text
---

