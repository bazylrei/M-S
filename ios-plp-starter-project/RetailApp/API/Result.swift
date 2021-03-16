import Foundation

/// A value that represents either a success or failure, capturing associated
/// values in both cases.
public enum Result<Value, Error> {
  /// A normal result, storing a `Value`.
  case value(Value)

  /// An error result, storing an `Error`.
  case error(Error)

  /// Evaluates the given transform closure when this `Result` instance is
  /// `.success`, passing the value as a parameter.
  ///
  /// Use the `map` method with a closure that returns a non-`Result` value.
  ///
  /// - Parameter transform: A closure that takes the successful value of the
  ///   instance.
  /// - Returns: A new `Result` instance with the result of the transform, if
  ///   it was applied.
  public func map<NewValue>(
    _ transform: (Value) -> NewValue
    ) -> Result<NewValue, Error> {
    switch self {
    case .value(let value):
      return Result<NewValue, Error>.value(transform(value))
    case .error(let error):
      return Result<NewValue, Error>.error(error)
    }
  }

  /// Evaluates the given transform closure when this `Result` instance is
  /// `.failure`, passing the error as a parameter.
  ///
  /// Use the `mapError` method with a closure that returns a non-`Result`
  /// value.
  ///
  /// - Parameter transform: A closure that takes the failure value of the
  ///   instance.
  /// - Returns: A new `Result` instance with the result of the transform, if
  ///   it was applied.
  public func mapError<NewError>(
    _ transform: (Error) -> NewError
    ) -> Result<Value, NewError> {
    switch self {
    case .value(let value):
      return Result<Value, NewError>.value(value)
    case .error(let error):
      return Result<Value, NewError>.error(transform(error))
    }
  }

  /// Evaluates the given transform closure when this `Result` instance is
  /// `.success`, passing the value as a parameter and flattening the result.
  ///
  /// - Parameter transform: A closure that takes the successful value of the
  ///   instance.
  /// - Returns: A new `Result` instance, either from the transform or from
  ///   the previous error value.
  public func flatMap<NewValue>(
    _ transform: (Value) -> Result<NewValue, Error>
    ) -> Result<NewValue, Error> {
    switch self {
    case .value(let value):
      return transform(value)
    case .error(let error):
      return Result<NewValue, Error>.error(error)
    }
  }

  /// Evaluates the given transform closure when this `Result` instance is
  /// `.failure`, passing the error as a parameter and flattening the result.
  ///
  /// - Parameter transform: A closure that takes the error value of the
  ///   instance.
  /// - Returns: A new `Result` instance, either from the transform or from
  ///   the previous success value.
  public func flatMapError<NewError>(
    _ transform: (Error) -> Result<Value, NewError>
    ) -> Result<Value, NewError> {
    switch self {
    case .value(let value):
      return Result<Value, NewError>.value(value)
    case .error(let error):
      return transform(error)
    }
  }
}

extension Result where Error == Swift.Error {
  /// Unwraps the `Result` into a throwing expression.
  ///
  /// - Returns: The success value, if the instance is a success.
  /// - Throws:  The error value, if the instance is a failure.
  public func unwrapped() throws -> Value {
    switch self {
    case .value(let value):
      return value
    case .error(let error):
      throw error
    }
  }

  /// Create an instance by capturing the output of a throwing closure.
  ///
  /// - Parameter throwing: A throwing closure to evaluate.
  public init(catching body: () throws -> Value) {
    do {
      self = .value(try body())
    } catch {
      self = Result<Value, Error>.error(error)
    }
  }
}

extension Result : Equatable where Value : Equatable, Error : Equatable { }

extension Result : Hashable where Value : Hashable, Error : Hashable { }
