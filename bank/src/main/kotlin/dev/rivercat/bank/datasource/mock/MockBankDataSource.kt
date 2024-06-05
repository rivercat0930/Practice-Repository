package dev.rivercat.bank.datasource.mock

import dev.rivercat.bank.datasource.BankDataSource
import dev.rivercat.bank.model.Bank
import org.springframework.stereotype.Repository

@Repository
class MockBankDataSource :BankDataSource {
    val banks = mutableListOf(
        Bank("1234-5678-9012", 87.1, 5),
        Bank("0987-2123-4525", 1.0, 100),
        Bank("0987-3892-1234", 10.0, 15)
    )

    override fun retrieveBanks(): Collection<Bank> = banks

    override fun retrieveBank(accountNumber: String): Bank =
        banks.firstOrNull { it.accountNumber == accountNumber }
            ?: throw NoSuchElementException("Could not find a bank with account number $accountNumber")

    override fun createBank(bank: Bank): Bank {
        if (banks.any{ it.accountNumber == bank.accountNumber})
            throw IllegalArgumentException("Bank with account number ${bank.accountNumber} already exists.")

        banks.add(bank)

        return bank
    }

    override fun updateBank(bank: Bank): Bank {
        val currentBank = banks.firstOrNull { it.accountNumber == bank.accountNumber }
            ?: throw NoSuchElementException("Could not find a bank with account number ${bank.accountNumber}")

        banks.remove(currentBank)
        banks.add(bank)

        return bank
    }

    override fun deleteBank(accountNumber: String) {
        val currentBank = banks.firstOrNull { it.accountNumber == accountNumber }
            ?: throw NoSuchElementException("Could not find a bank with account number accountNumber")

        banks.remove(currentBank)
    }
}
