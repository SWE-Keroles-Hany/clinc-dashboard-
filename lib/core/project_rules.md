# Project Rules

## Formal Rules

- Use Flutter recommended lints from `flutter_lints`.
- Dart SDK version is `^3.11.5`.
- The app is private and should not be published to pub.dev.
- Assets belong in `assets/icons/` or `assets/images/`.

## Architecture

- Follow feature-based Clean Architecture.
- Feature folders should use this structure:
  - `data`
  - `domain`
  - `presentation`
- Shared code belongs in `lib/core`.
- Main feature modules currently include:
  - `auth`
  - `dashboard_tab`
  - `patient_tab`
  - `appointments_tab`
  - `settings_tab`

## State Management

- Use `flutter_bloc`.
- Use `Cubit` for feature state management.
- Feature state files should follow the existing naming style:
  - `<feature>_cubit.dart`
  - `<feature>_states.dart`
  - `<feature>_cubit_provider.dart`

## Data Flow

Use the current app flow:

```text
Screen / Widget
-> Cubit
-> UseCase
-> Repository
-> RemoteDataSource
-> DioServices
-> API
```

## Networking

- Use `dio` for API calls.
- Keep API endpoints in `core/network/api_constants.dart`.
- Send requests through `DioServices`.
- Add the saved token to requests through `DioInterceptors`.
- Wrap errors with the shared `Failure` class.

## Results And Errors

- Repository methods should return `Either<Failure, Data>` where possible.
- Use `Failure` for domain/data errors.
- Cubits should emit loading, success, and error states.

## Models And Entities

- Domain layer uses entities.
- Data layer uses models.
- Convert between models and entities using mapper files.

## Routing

- Keep named routes in `core/routes/app_routes.dart`.
- Each screen should expose a static `routeName`.

## UI

- Shared colors belong in `ColorManager`.
- Shared text styles belong in `AppTextStyles`.
- Shared widgets belong in `core/widgets`.
- App-wide theme belongs in `AppTheme`.

## Validation

- Keep form validation in `core/helper/validations/app_validations.dart`.
- Current validation rules:
  - Name: at least 3 characters.
  - Email: must contain `@`.
  - Phone number: at least 11 characters.
  - Password: at least 8 characters.
  - Confirm password: must match password.
  - Address: at least 3 characters.

## Dependency Creation

- `get_it` exists, but `service_locator.dart` is currently empty.
- Existing Cubits are created manually through provider helper functions such as `createAuthCubit()`.
