package dev.rivercat.bank.datasource

import dev.rivercat.bank.model.Bank

interface BankDataSource {
    fun retrieveBanks() : Collection<Bank>
    fun retrieveBank(accountNumber: String): Bank
    fun createBank(bank: Bank): Bank
    fun updateBank(bank: Bank): Bank
    fun deleteBank(accountNumber: String)
}
