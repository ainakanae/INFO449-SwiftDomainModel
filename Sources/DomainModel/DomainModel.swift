struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//

public struct Money {
    
    var amount: Int
    
    var currency: String
    
    init(amount: Int, currency: String) {
        if !["USD", "GBP", "EUR", "CAN"].contains(currency) {
            fatalError("Unknown name")
        }
        self.amount = amount
        self.currency = currency
    }
    
    func convert(_ currentCurrency: String) -> Money {
        
        let conversionRates: [String: Double] =
        ["USD": 1.0,
         "GBP": 0.5,
         "EUR": 1.5,
         "CAN": 1.25]
        
        let ratioToUS = Double(amount) / conversionRates[currency]!
        
        let convertedAmount = Int(ratioToUS * conversionRates[currentCurrency]!)
        return Money(amount: convertedAmount, currency: currentCurrency)
    }
    
    
    
    func add(_ moneyToAdd: Money) -> Money {
        if self.currency == moneyToAdd.currency {
            return Money(amount: self.amount + moneyToAdd.amount, currency: moneyToAdd.currency)
        } else {
            let convertedInput = self.convert(moneyToAdd.currency)
            return Money(amount: convertedInput.amount + self.amount, currency: moneyToAdd.currency)
        }
    }
    
    func subtract(_ moneyToSubtract: Money) -> Money {
        if self.currency == moneyToSubtract.currency {
            return Money(amount: self.amount - moneyToSubtract.amount, currency: moneyToSubtract.currency)
        } else {
            let convertedInput = self.convert(moneyToSubtract.currency)
            return Money(amount: convertedInput.amount - self.amount, currency: moneyToSubtract.currency)
        }
    }
    
}


////////////////////////////////////
// Job
//
public class Job {
    
    var title: String
    
    var type: JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
        
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
        
    func calculateIncome(_ hours: Int = 2000) -> Int {
        switch type {
        case .Hourly(let wage):
            return Int(wage * Double(hours))
        case .Salary(let salary):
            return Int(salary)
        }
    }
    
    func raise(amountOfRaise amount: Double) {
        switch type {
        case .Hourly(let wage):
            type = .Hourly(wage + Double(amount))
        case .Salary(let salary):
            type = .Salary(salary + UInt(Int(amount)))
        }
    }
    
    func raise(percentageOfRaise percentage: Double) {
        switch type {
        case .Hourly(let wage):
            type = .Hourly(wage * (1 + percentage))
        case .Salary(let salary):
            type = .Salary(UInt(Int(Double(salary) * (1 + percentage))))
        }
    }

    
}

////////////////////////////////////
// Person
//
public class Person {
    var firstName: String
    var lastName: String
    var age: Int
    
}


////////////////////////////////////
// Family
//
public class Family {
    var members: [Person]
}

