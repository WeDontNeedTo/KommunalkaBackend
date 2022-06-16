import Fluent
import Vapor

final class Payment: Model, Content {
    static let schema = "payments"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "hotWaterCount")
    var hotWaterCount: Int

    @Field(key: "coldWaterCount")
    var coldWaterCount: Int

    @Field(key: "electricity")
    var electricity: Int

    @Field(key: "date")
    var date: String

    init() { }

    init(id: UUID? = nil, hotWaterCount: Int, coldWaterCount: Int, electricity: Int, date: String) {
        self.id = id
        self.hotWaterCount = hotWaterCount
        self.coldWaterCount = coldWaterCount
        self.electricity = electricity
        self.date = date
    }
}
