//
//  UserService_Test.swift
//  UserService Test
//
//  Created by Edgars Baumanis on 06.03.19.
//  Copyright © 2019. g. chili. All rights reserved.
//

import XCTest

class LoginFunc_Test: XCTestCase {

    var userService: DumbUserService?
    var loginVM: LoginModel?

    override func setUp() {
        userService = DumbUserService()
        guard let myUserService = userService else {return}
        loginVM = LoginModel(userService: myUserService)
    }

    override func tearDown() {
        userService = nil
        loginVM = nil
    }

    func testLogin() {
        loginVM?.loginUser(email: "email@email.com", password: "123456")
        XCTAssertTrue(loginVM?.error == "There is no error")

        loginVM?.loginUser(email: "a@a.aa", password: "123456")
        XCTAssertTrue(loginVM?.error == "There is no error")

        loginVM?.loginUser(email: "em.il@email.com", password: "123456")
        XCTAssertTrue(loginVM?.error == "There is no error")
    }


    func testBadLogin() {
        
        loginVM?.loginUser(email: "", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "email@email.c", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "@email.com", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "email.com", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: ".com", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "email@.com", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "email@email", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: ".mail@email", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "email@emailaaaaaaā", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: ".mail@emailaaaaaaā", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "maksims@ma.com.", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")

        loginVM?.loginUser(email: "email@emailaaaaaaā", password: "123456")
        XCTAssertTrue(loginVM?.error == "This is an error")
    }
}
