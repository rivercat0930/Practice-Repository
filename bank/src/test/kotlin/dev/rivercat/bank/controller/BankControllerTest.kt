package dev.rivercat.bank.controller

import com.fasterxml.jackson.databind.ObjectMapper
import dev.rivercat.bank.model.Bank
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.annotation.DirtiesContext
import org.springframework.test.web.servlet.*

@SpringBootTest
@AutoConfigureMockMvc
@DirtiesContext
internal class BankControllerTest @Autowired constructor (
    val mockMvc: MockMvc,
    val objectMapper: ObjectMapper
) {
    val baseUrl = "/api/banks"

    @Nested
    @DisplayName("GET /api/banks")
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    inner class GetBanks {
        @Test
        fun `should return all banks`() {
            // when/then
            mockMvc.get(baseUrl)
                .andDo { print() }
                .andExpect {
                    status { isOk() }
                    content { content { MediaType.APPLICATION_JSON } }
                    jsonPath("$[0].accountNumber") { value("1234-5678-9012") }
                }
        }
    }

    @Nested
    @DisplayName("GET /api/banks/{accountNumber}")
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    inner class GetBank {
        @Test
        fun `should return the bank with the given account number`() {
            // given
            val accountNumber = "1234-5678-9012"

            // when/then
            mockMvc.get("$baseUrl/$accountNumber")
                .andDo { print() }
                .andExpect {
                    status { isOk() }
                    jsonPath("$.trust") { value("87.1") }
                    jsonPath("$.transactionFee") { value("5") }
                }
        }

        @Test
        fun `should return NOT FOUND if the account number does not exist`() {
            // given
            val accountNumber = "DOES_NOT_EXIST"

            // when/then
            mockMvc.get("$baseUrl/$accountNumber")
                .andDo { print() }
                .andExpect {
                    status { isNotFound() }
                }
        }
    }

    @Nested
    @DisplayName("POST /api/banks")
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    inner class AddBank {
        @Test
        fun `should add the new bank`() {
            // given
            val newBank = Bank("abcd1234", 22.1, 87)

            // when
            val performPost = mockMvc.post(baseUrl) {
                contentType = MediaType.APPLICATION_JSON
                content = objectMapper.writeValueAsString(newBank)
            }

            // then
            performPost
                .andDo { print() }
                .andExpect {
                    status { isCreated() }
                    content {
                        contentType(MediaType.APPLICATION_JSON)
                        json(objectMapper.writeValueAsString(newBank))
                    }
                }
        }

        @Test
        fun `should return BAD REQUEST if bank with given account number already exists`() {
            // given
            val invalidBank = Bank("1234-5678-9012", 87.1, 5)

            // when
            val performPost = mockMvc.post(baseUrl) {
                contentType = MediaType.APPLICATION_JSON
                content = objectMapper.writeValueAsString(invalidBank)
            }

            // then
            performPost
                .andDo { print() }
                .andExpect { status { isBadRequest() } }
        }
    }

    @Nested
    @DisplayName("PATCH /api/banks")
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    inner class PatchExistingBank {
        @Test
        fun `should update an existing bank`() {
            // given
            val updatedBank = Bank("0987-3892-1234", 87.0, 87)

            // when
            val performPatch = mockMvc.patch(baseUrl) {
                contentType = MediaType.APPLICATION_JSON
                content = objectMapper.writeValueAsString(updatedBank)
            }

            // then
            performPatch
                .andDo { print() }
                .andExpect {
                    status { isOk() }
                    content {
                        contentType(MediaType.APPLICATION_JSON)
                        json(objectMapper.writeValueAsString(updatedBank))
                    }
                }

            mockMvc.get("${baseUrl}/${updatedBank.accountNumber}")
                .andExpect {
                    content {
                        contentType(MediaType.APPLICATION_JSON)
                        json(objectMapper.writeValueAsString(updatedBank))
                    }
                }
        }

        @Test
        fun `should return BAD REQUEST if no bank with given account number exists`() {
            // given
            val invalidBank = Bank("DOES_NOT_EXIST", 0.0, 0)

            // when
            val performPatchRequest = mockMvc.patch(baseUrl) {
                contentType = MediaType.APPLICATION_JSON
                content = objectMapper.writeValueAsString(invalidBank)
            }

            // then
            performPatchRequest
                .andDo { print() }
                .andExpect {
                    status { isNotFound() }
                }
        }
    }

    @Nested
    @DisplayName("DELETE /api/banks/{accountNumber}")
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    inner class DeleteExistingBank {
        @Test
        fun `should delete the bank with the given account number`() {
            // given
            val accountNumber = "0987-3892-1234"

            // when/then
            mockMvc.delete("$baseUrl/$accountNumber")
                .andDo { print() }
                .andExpect {
                    status { isNoContent() }
                }

            mockMvc.get("$baseUrl/$accountNumber")
                .andDo { print() }
                .andExpect {
                    status { isNotFound() }
                }
        }

        @Test
        fun `should return NOT FOUND if no bank with given account number exists`() {
            // given
            val invalidAccountNumber = "DOES_NOT_EXIST"

            // when/then
            mockMvc.delete("$baseUrl/$invalidAccountNumber")
                .andDo { print() }
                .andExpect {
                    status { isNotFound() }
                }
        }
    }
}
