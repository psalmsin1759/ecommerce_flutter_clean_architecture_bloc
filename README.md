# Flutter E-commerce App

This project is a Flutter E-commerce Mobile Application built with Clean Architecture and BLoC (Business Logic Component) for state management. It provides a scalable, testable, and maintainable codebase that follows SOLID principles.


## Features

- Onboarding screens with smooth page indicators

- Authentication (Login / Register)

- Product listing & product details

- Shopping cart with checkout flow

- Persistent local storage with SharedPreferences

- REST API integration using Dio

- Centralized dependency injection using GetIt

- Error handling with Dartz (Either & Option types)

- Logging with Logger for debugging

## Architecture

This app follows Clean Architecture with separation of concerns into 3 main layers:

```bash

lib/
├── core/                # Shared utilities (errors, constants, helpers)
├── features/            # Each feature has its own folder
│   ├── auth/
│   │   ├── data/        # Data layer (repositories, datasources, models)
│   │   ├── domain/      # Domain layer (entities, repositories, use cases)
│   │   ├── presentation/# Presentation layer (bloc, pages, widgets)
│   │
│   ├── product/
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │
│   └── cart/
│       ├── data/
│       ├── domain/
│       ├── presentation/
│
├── injection.dart       # GetIt service locator setup
└── main.dart            # Entry point


```