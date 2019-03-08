//
//  Event_PlannerTests.swift
//  Event_PlannerTests
//
//  Created by Edgars Baumanis on 06.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import XCTest

class Event_PlannerTests: XCTestCase {

    

    override func setUp() {

    }

    override func tearDown() {

    }

    func testEmailIsValid() {
        XCTAssertTrue(EmailValidator.regExValid(email: "email@email.com"))
        XCTAssertTrue(EmailValidator.regExValid(email: "a@a.aa"))
        XCTAssertTrue(EmailValidator.regExValid(email: "em.il@email.com"))
        XCTAssertTrue(EmailValidator.isValid("email@email.com"))
        XCTAssertTrue(EmailValidator.isValid("a@a.aa"))
        XCTAssertTrue(EmailValidator.isValid("em.il@email.com"))
    }

    func testEmailIsNotValid() {
        XCTAssertFalse(EmailValidator.regExValid(email: ""))
        XCTAssertFalse(EmailValidator.regExValid(email: "email@email.c"))
        XCTAssertFalse(EmailValidator.regExValid(email: "@email.com"))
        XCTAssertFalse(EmailValidator.regExValid(email: "email.com"))
        XCTAssertFalse(EmailValidator.regExValid(email: ".com"))
        XCTAssertFalse(EmailValidator.regExValid(email: "email@.com"))
        XCTAssertFalse(EmailValidator.regExValid(email: "email@email"))
        XCTAssertFalse(EmailValidator.regExValid(email: ".mail@email"))
        XCTAssertFalse(EmailValidator.regExValid(email: "email@emailaaaaaaā"))
        XCTAssertFalse(EmailValidator.regExValid(email: ".mail@emailaaaaaaā"))
        XCTAssertFalse(EmailValidator.regExValid(email: "maksims@ma.com."))
        XCTAssertFalse(EmailValidator.isValid(""))
        XCTAssertFalse(EmailValidator.isValid("emailemail.com"))
        XCTAssertFalse(EmailValidator.isValid("email@email.c"))
        XCTAssertFalse(EmailValidator.isValid("@email.com"))
        XCTAssertFalse(EmailValidator.isValid("email.com"))
        XCTAssertFalse(EmailValidator.isValid(".com"))
        XCTAssertFalse(EmailValidator.isValid("email@.com"))
        XCTAssertFalse(EmailValidator.isValid("email@email"))
        XCTAssertFalse(EmailValidator.isValid(".mail@email"))
        XCTAssertFalse(EmailValidator.isValid("email@emailaaaaaaā"))
        XCTAssertFalse(EmailValidator.isValid(".mail@emailaaaaaaā"))


    }
}

class EmailValidator {

    class func isValid(_ email: String) -> Bool {

        let before = email.components(separatedBy: "@")
        let length = email.count
        if length >= 6 && length <= 15 && email.contains("@") && before[1].contains(".") {
            let user = before[0]
            if user.count >= 1 {
                let wholeDomain = before[1].components(separatedBy: ".")
                let domain = wholeDomain[0]
                if domain.count >= 1 {
                    let end = wholeDomain[1]
                    if end.count >= 2 && end.count > 1 {
                        return true
                    } else {return false}
                } else {return false}
            } else {return false}
        } else {return false}
    }

    class func regExValid(email: String) -> Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format: "SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)
    }
}


