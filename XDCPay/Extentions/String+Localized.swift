//
//  String+Localized.swift
//  Babypass
//
//  Created by iOS Developer on 2021-08-29.
//

import Foundation

extension String {
    /** The prefix to use when a localized string is not found. */
    public static let localizedStringNotFoundPrefix: String = "[?]"

    /** Attempts to get a localized version of the current string by using the current string as a key.
     If the localized string is not found, the key is returned and a warning is logged with dev analytics.
     - Parameter tableName: The file name where the string is located.
     - Parameter comment: A comment to inject into the xliff file on export.  This is additional description that will help translators translate this string.
     - Parameter arguments: A variable argument list to inject into the string.
     - Returns: Returns the found localized string or self if not found.
     */
    public func localized(tableName: String? = nil, comment: String = "No Comment", _ arguments: CVarArg...) -> String {
        let defaultValue: String = "\(String.localizedStringNotFoundPrefix)\(self)"
        let localizedString: String = NSLocalizedString(self, tableName: tableName, value: defaultValue, comment: comment)

        // If failed to find the value
        if localizedString == defaultValue {

            // Return the default string if in prodcution.
            // Return the default value with concatinated warning if in dev.
            return defaultValue
        }

        // Make sure we are passing in right ammount ammount of parameters the string is expecting.
        // If not, a crash will occur on a release build.
        let numberOfExpectedParameters: Int = localizedString.getNumberOfExpectedParameters()
        if numberOfExpectedParameters != arguments.count {
            return defaultValue + ": WrongParameterCount"
        }

        // If there are no arguments to inject, return the localized string.
        if arguments.isEmpty {
            return localizedString
        }

        // Get the string with injected parameters.
        let result: String = withVaList(arguments) {
            (NSString(format: localizedString, locale: NSLocale.current, arguments: $0) as String)
        }

        return result
    }
}
