//
//  TSConsoleLogger.swift
//  Trustbadge
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
    func log(
        messege: String,
        severity: TSLogSeverity,
        file: String = #file,
        method: String = #function
    ) {
        // Extract the filename from the full path
        let filename: String = (file as NSString).lastPathComponent

        // Extract the method name without the parameter list
        let methodName = self.getMethodName(for: method)

        // Get timestamp in Hour:Minute:Second format
        let timeStamp = Date().toStringWithHourMinuteAndSecond()

        print("[\(timeStamp)] \(filename):\(methodName) \(severity.label):\(messege)")
    }

    // MARK: Private methods

    /**
     Returns just the method name for the given function signature
     */
    private func getMethodName(for method: String) -> String {
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