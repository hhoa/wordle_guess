# wordle_guess

## Introduction

This application is made by Flutter. I get the idea from WORDLE! app in stores so basically it has 
many same features but I also integrate Gemini chatbot to take some guesses.

## Prerequisite

To run the app, you need to setup Flutter in your machine. Please refer to [flutter.dev](https://docs.flutter.dev/get-started/install) for full setup

## Development

I use Flutter version 3.24.5 and Android studio to develop. You shouldn't see any warning in Dart Analysis when using this Flutter version

## Project structure:

```
src
├── constant
├── data
├── domain
├── enum
├── extension
├── model
├── pages
├── resources
├── routes
├── utils
└── widgets
```

## State Management: [GetX](https://pub.dev/packages/get)

## Run the app

This app can be run on Android, iOS and Web. But to use Gemini to guess, 
you need to pass `gemini_key` in additional run agrs

- **Install package dependencies**

  ```shell
  flutter pub get
  ```

Then you can run

  ```shell
  flutter run --dart-define=gemini_key=YOUR_KEY
  ```

and choose device you want to run.

You can also run test in this repo

  ```shell
  flutter test
  ```

it should show `All tests passed!` after running.

## Miscellaneous information

1/ Since this is prototype application so I use google_generative_ai with gemini_key from args. 
In prod app, we should use Vertex AI in Firebase

## Demo

You can find the demo [here](https://drive.google.com/file/d/1dqDU8UevJiPzIfxYcXlwjF9o6EA_B4rK/view?usp=sharing)

## About me

I'm Hoa Hoang, a software engineer based in HCMC, Vietnam. I love to work and always seek for new challenge.
You can find more details about me [here](https://flutter-portfolio-e116e.web.app/)