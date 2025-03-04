package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequestMapping("/demo")
public class demo {
    @GetMapping
    public String test() {
        return "Hello World demo";
    }
    @GetMapping("/api")
    public String test1() {
        return "Hello Bro demo";
    }
}