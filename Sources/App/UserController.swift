//
//  UserController.swift
//  App
//
//  Created by sure on 2019/6/25.
//

import Vapor

struct UserController : RouteCollection {
    func boot(router: Router) throws {
        let userRoute = router.grouped("api","users")
        userRoute.post(User.self, use: creatHandle)
        
    }
    
    func creatHandle(_ req: Request,user: User) throws -> Future<User> {
        return user.save(on: req)
    }
    
}
