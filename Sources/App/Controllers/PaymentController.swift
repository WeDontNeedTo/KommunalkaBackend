import Fluent
import Vapor

struct PaymentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let payments = routes.grouped("api", "v1", "payments")
        payments.get(use: index)
        payments.post(use: create)
        payments.group(":paymentID") { payment in
            payment.delete(use: delete)
            payment.patch(use: update)
        }
    }
    
    func index(req: Request) async throws -> [Payment] {
        try await Payment.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Payment {
        let payment = try req.content.decode(Payment.self)
        try await payment.save(on: req.db)
        return payment
    }
    
    func delete(req: Request) async throws -> HTTPStatus {
        guard let payment = try await Payment.find(req.parameters.get("paymentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await payment.delete(on: req.db)
        return .ok
    }
    
    func update(req: Request) async throws -> Payment {
        let newPayment = try req.content.decode(PaymentPatch.self)

        guard let payment = try await Payment.find(req.parameters.get("paymentID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        if let coldWater = newPayment.coldWaterCount {
            payment.coldWaterCount = coldWater
        }
        
        if let hotWater = newPayment.hotWaterCount {
            payment.hotWaterCount = hotWater
        }
        
        if let electricity = newPayment.electricity {
            payment.electricity = electricity
        }
        
        if let date = newPayment.date {
            payment.date = date
        }
        
        try await payment.save(on: req.db)
        
        return payment
    }
}
