import Foundation

class Observable<T> {
  class Observer {
    typealias ObserverAction = (T) -> Void

    fileprivate weak var observer: AnyObject?
    fileprivate var action: ObserverAction

    init(_ observer: AnyObject, action: @escaping ObserverAction) {
      self.observer = observer
      self.action = action
    }
  }

  /// Updating that value will trigger all bindings
  var value: T {
    didSet {
      observers.forEach { $0.action(value) }
    }
  }

  private var observers: [Observable<T>.Observer] = []

  init(_ value: T) {
    self.value = value
  }

  func bindNoFire(_ observer: AnyObject, _ action: @escaping Observer.ObserverAction) {
    cleanListeners()
    observers += [Observer(observer, action: action)]
  }

  func bind(_ observer: AnyObject, _ action: @escaping Observer.ObserverAction) {
    bindNoFire(observer, action)
    if let observer = observers.first(where: { $0.observer === observer }) {
      observer.action(value)
    }
  }

  func unbind(_ observer: AnyObject) {
    if let index = observers.firstIndex(where: { $0.observer === observer }) {
      observers.remove(at: index)
    }
  }

  func unbindAll() {
    observers.removeAll()
  }

  private func cleanListeners() {
    if let indexToRemove = observers.enumerated().first(where: { $0.element.observer == nil })?.offset {
      observers.remove(at: indexToRemove)
      cleanListeners()
    }
  }
}
