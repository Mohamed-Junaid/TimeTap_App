# Timetapping Challenge App
## Overview
This is a Flutter application called the "Timetapping Challenge" developed by Mohamed Junaid. It is a simple game-like app where users have to tap a button within a certain timeframe based on a randomly generated number.

## Features
* Countdown Timer: A countdown timer is displayed to the user indicating the time remaining to tap the button.
* Random Number Generation: A random number is generated, and the user has to tap the button when the current second matches the generated number.
* Feedback: Users receive feedback indicating success or failure based on their tapping action.
* State Management with setState: The app utilizes setState for managing the application's state. Each time the state needs to be updated, setState is called, triggering a rebuild of the UI with the updated state.
* Persistence: User data such as countdown duration, number of attempts, and successful attempts are stored locally using SharedPreferences for persistent data storage.

## Technologies Used
* Flutter: Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. It was used to develop the frontend of the application.
* SharedPreferences: SharedPreferences is a key-value storage mechanism used to store user data locally in the Flutter application.

## Installation
To run the application locally, follow these steps:
* Clone the repository to your local machine.
* Ensure you have Flutter installed on your machine.
* Open the project in your preferred IDE.
* Run the app on an emulator or physical device.

## How to Play 
- Launch the application on your device.
- Tap the "Click" button when the current second matches the randomly generated number.
- Receive feedback on success or failure.
- The countdown timer indicates the time remaining for each attempt.
- Your score is displayed as successful attempts out of total attempts.

### To perform a full reset
follow these steps:
   - Tap on the menu icon.
   - Select the "Full Reset" option.

## Developer
* Mohamed Junaid
  ##### Flutter Developer
  ##### Malappuram,Kerala

  ### Support or Contact
For any inquiries or support regarding the application, please contact Mohamed Junaid at junaid3314@gmail.com.
