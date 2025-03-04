package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequestMapping("/test")
public class test {
    @GetMapping
    public String test() {
        return "Hello World";
    }
    @GetMapping("/api")
    public String test1() {
        return "Hello Bro";
    }
}
    