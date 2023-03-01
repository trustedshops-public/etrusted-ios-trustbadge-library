//
//  Copyright (C) 2023 Trusted Shops GmbH
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Prem Pratap Singh on 08/11/22.
//

import Foundation

/**
 TSConsoleLogger logs messeges to the Xcode console with other given details like date and time stamp,
 source type, method, severity, etc
 */
public class TSConsoleLogger: TSLogger {

    // MARK: Public methods

    /**
     Logs messege to the console with given details like severity, file and method names
     */
    public static func log(
        messege: String,
        severity: TSLogSeverity,
        file: String = #file,
        method: String = #function
    ) {
        // Extract the filename from the full path
        let filename: String = (file as NSString).lastPathComponent

        // Extract the method name without the parameter list
        let methodName = TSConsoleLogger.getMethodName(for: method)

        // Get timestamp in Hour:Minute:Second format
        let now = Date()
        let dateStamp = now.toStringWithYearMonthAndDate()
        let timeStamp = now.toStringWithHourMinuteAndSecond()

        print("[\(dateStamp) \(timeStamp)] [Trustylib] \(severity.label) \(filename):\(methodName):\(messege)")
    }

    // MARK: Private methods

    /**
     Returns just the method name for the given function signature
     */
    private static func getMethodName(for method: String) -> String {
        var methodName = method
        if let regex = try? NSRegularExpression(pattern: "\\([^\\)]*\\)") {
            methodName = regex.stringByReplacingMatches(
                in: methodName,
                options: [],
                range: NSRange(location: 0, length: methodName.count),
                withTemplate: ""
            )
        }
        return methodName
    }
}
