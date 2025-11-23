//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Foundation

#if canImport(os) && !SOURCEKIT_LSP_FORCE_NON_DARWIN_LOGGER
@_exported public import os  // os_log

package typealias LogLevel = os.OSLogType
@available(macOS 11.0, *)
package typealias Logger = os.Logger
@available(macOS 12.0, *)
package typealias Signposter = OSSignposter

@available(macOS 12.0, *)
extension OSSignposter: @retroactive @unchecked Sendable {}
//extension OSSignpostID: @retroactive @unchecked Sendable {}
@available(macOS 12.0, *)
extension OSSignpostIntervalState: @retroactive @unchecked Sendable {}

@available(macOS 11.0, *)
extension os.Logger {
    @available(macOS 12.0, *)
    package func makeSignposter() -> Signposter {
    return OSSignposter(logger: self)
  }
}
#else
package typealias LogLevel = NonDarwinLogLevel
package typealias Logger = NonDarwinLogger
package typealias Signposter = NonDarwinSignposter
#endif

/// The logger that is used to log any messages.
@available(macOS 11.0, *)
package var logger: Logger {
    #if LOGGING
    Logger(subsystem: LoggingScope.subsystem, category: LoggingScope.scope)
    #else
    Logger(.disabled)
    #endif
}
