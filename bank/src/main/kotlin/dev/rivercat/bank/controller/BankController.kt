package dev.rivercat.bank.controller

import dev.rivercat.bank.model.Bank
import dev.rivercat.bank.service.BankService
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/banks")
class BankController(private val service : BankService) {
    @ExceptionHandler(NoSuchElementException::class)
    fun handleNotFound(e : NoSuchElementException) : ResponseEntity<String> =
        ResponseEntity(e.message, HttpStatus.NOT_FOUND)

    @ExceptionHandler(IllegalArgumentException::class)
    fun handleBadRequest(e : IllegalArgumentException) : ResponseEntity<String> =
        ResponseEntity(e.message, HttpStatus.BAD_REQUEST)

    @GetMapping
    fun getBanks() : Collection<Bank> = service.getBanks()

    @GetMapping("/{accountNumber}")
    fun getSingleBank(@PathVariable accountNumber : String) : Bank = service.getBank(accountNumber)

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    fun addBank(@RequestBody bank : Bank) : Bank = service.addBank(bank)

    @PatchMapping
    fun updateBank(@RequestBody bank : Bank) : Bank = service.updateBank(bank)

    @DeleteMapping("/{accountNumber}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    fun deleteBank(@PathVariable accountNumber: String) : Unit = service.deleteBank(accountNumber)
}