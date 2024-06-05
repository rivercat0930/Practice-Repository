package dev.rivercat.bank.datasource.mock

import org.assertj.core.api.Assertions
import org.junit.jupiter.api.Test

internal class MockBankDataSourceTest {
    private val mockDataSource = MockBankDataSource()

    @Test
    fun `should provide a collection of banks`() {
        // given

        // when
        val banks = mockDataSource.retrieveBanks()

        // then
        Assertions.assertThat(banks).isNotEmpty()
    }

    @Test
    fun `should provide some mock data`() {
        // given

        // when
        val banks = mockDataSource.retrieveBanks()

        // then
        Assertions.assertThat(banks).allMatch { it.accountNumber.isNotBlank() }
    }
}
