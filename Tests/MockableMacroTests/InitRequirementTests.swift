//
//  InitRequirementTests.swift
//
//
//  Created by Kolos Foltanyi on 2023. 11. 23..
//

import MacroTesting
import XCTest

final class InitRequirementTests: MockableMacroTestCase {
    func test_init_requirement() {
        assertMacro {
          """
          @Mockable
          protocol Test {
              init()
              init(name: String)
          }
          """
        } expansion: {
            """
            protocol Test {
                init()
                init(name: String)
            }

            #if MOCKING
            final class MockTest: Test, Mockable.MockableService {
                typealias Mocker = Mockable.Mocker<MockTest>
                private let mocker = Mocker()
                @available(*, deprecated, message: "Use given(_ service:) instead. ")
                var given: ReturnBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use when(_ service:) instead. ")
                var when: ActionBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use verify(_ service:) instead. ")
                var verify: VerifyBuilder {
                    .init(mocker: mocker)
                }
                func reset(_ scopes: Set<Mockable.MockerScope> = .all) {
                    mocker.reset(scopes: scopes)
                }
                init(policy: Mockable.MockerPolicy? = nil) {
                    if let policy {
                        mocker.policy = policy
                    }
                }
                init() {
                }
                init(name: String) {
                }
                enum Member: Mockable.Matchable, Mockable.CaseIdentifiable {
                    func match(_ other: Member) -> Bool {
                        switch (self, other) {
                        }
                    }
                }
                struct ReturnBuilder: Mockable.Builder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                }
                struct ActionBuilder: Mockable.Builder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                }
                struct VerifyBuilder: Mockable.Builder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                }
            }
            #endif
            """
        }
    }

    func test_multiple_init_requirement() {
        assertMacro {
          """
          @Mockable
          protocol Test {
              init?() async throws
              init(name: String)
              init(name value: String, _ index: Int)
          }
          """
        } expansion: {
            """
            protocol Test {
                init?() async throws
                init(name: String)
                init(name value: String, _ index: Int)
            }

            #if MOCKING
            final class MockTest: Test, Mockable.MockableService {
                typealias Mocker = Mockable.Mocker<MockTest>
                private let mocker = Mocker()
                @available(*, deprecated, message: "Use given(_ service:) instead. ")
                var given: ReturnBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use when(_ service:) instead. ")
                var when: ActionBuilder {
                    .init(mocker: mocker)
                }
                @available(*, deprecated, message: "Use verify(_ service:) instead. ")
                var verify: VerifyBuilder {
                    .init(mocker: mocker)
                }
                func reset(_ scopes: Set<Mockable.MockerScope> = .all) {
                    mocker.reset(scopes: scopes)
                }
                init(policy: Mockable.MockerPolicy? = nil) {
                    if let policy {
                        mocker.policy = policy
                    }
                }
                init?() async throws {
                }
                init(name: String) {
                }
                init(name value: String, _ index: Int) {
                }
                enum Member: Mockable.Matchable, Mockable.CaseIdentifiable {
                    func match(_ other: Member) -> Bool {
                        switch (self, other) {
                        }
                    }
                }
                struct ReturnBuilder: Mockable.Builder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                }
                struct ActionBuilder: Mockable.Builder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                }
                struct VerifyBuilder: Mockable.Builder {
                    private let mocker: Mocker
                    init(mocker: Mocker) {
                        self.mocker = mocker
                    }
                }
            }
            #endif
            """
        }
    }
}
