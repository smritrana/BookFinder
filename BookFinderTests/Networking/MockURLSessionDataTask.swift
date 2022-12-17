//
//  MockURLSessionDataTask.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTask {

    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
