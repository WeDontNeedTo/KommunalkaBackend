import Fluent

struct CreatePayment: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("payments")
            .id()
            .field("hotWaterCount", .int, .required)
            .field("coldWaterCount", .int, .required)
            .field("electricity", .int, .required)
            .field("date", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("payments").delete()
    }
}
