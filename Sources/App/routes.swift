import Vapor

struct recepeteData : Content {
    let name : String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.post(recepeteData.self, at: "info") { (req, data) -> String in
        return data.name
    }
    
    router.post("api","Todo") { (req) -> Future<Todo> in
        return try req.content.decode(Todo.self).flatMap(to: Todo.self
            , { Todo in
                return Todo.save(on: req)
        })
    }
    
    router.get("api","OneTodo",Todo.parameter) { (req) -> Future<Todo> in
        return try req.parameters.next(Todo.self)
    }
    
    router.put("api","changeTodo",Todo.parameter) { (req) -> Future<Todo> in
        return try flatMap(to: Todo.self, req.parameters.next(Todo.self), req.content.decode(Todo.self), { (Todo, updatedTodo) -> Future<Todo> in
            Todo.name = updatedTodo.name
            Todo.title = updatedTodo.title
            Todo.id   = updatedTodo.id
            
            return Todo.save(on: req)
        })
    }

    let userController = UserController()
    try router.register(collection: userController)
    
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
