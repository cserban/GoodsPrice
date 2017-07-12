local - price
cart default currency
better memory management at quate split

move logic from cart to quateProvider
goods provider rename 
goods provider data source

# GoodsPrice

Goods Price is an iOS 10 app that helps you compute price of your cart in different currencies

# Requirements
1. Xcode 8.3.1+
2. iOS 10.3+
3. apilayer key, configure in xcconfig for debug or production

# Build Configuration
1. Debug Scheme - .xcconfig setup with 0 compile optimisation and gathering  of test coverage data
2. QA Scheme - .xcconfig setup with 0 compile optimisation and gathering of test coverage data
3. Staging Scheme - .xcconfig setup with Fast compile optimisation
4. Staging Scheme - .xcconfig setup with Fast compile optimisation


# Get Started
1. Clone Project 
2. Solve signing errors
3. Be sure you are on Debug configuration
4. Run all tests (cmd+ U)

# Data Model

## Product
Product model
- displayName: String
- priceValue: Float
- currencyCode: String
- messureUnit: String

## CurrencyResponse
Currency response 
- success: Bool
- terms: String
- privacy: String
- timestamp: Int
- source: String
- quotes: [String: Double]

## Resource
Web resource model
- url: URL
- method: HttpMethod
- parse: (Data) -> A?

## Cart
Cart model
- elements = [AnyHashable: Int]()
- totalPriceUnits: Float = 0.0
- currencyCode: String?
- doubleQuateCharactersCount = 6

## ThemeManager
Theme Manager model  

# Class diagram

# To DO
1. Add unit tests for UI components (controllers and views) 
2. Add UI tests 
3. Add logging on different levels based on build configuration
4. Handle network errors 
5. Add Locale price format - now uses default current format in Float extension - toCurrencyStringWith
6. Move out convert logic from Cart class - Not respecting SRP 
7. Refactor - Find uniform name for goods and products
8. Refactor - View Controller
9. Refactor - cache currency keys 
10. Add persistency - use userDefaults to persist preferred currency
11. Add persistency - use coreData to create a cache layer for currency list
12. Add font managment in Theme Manager
