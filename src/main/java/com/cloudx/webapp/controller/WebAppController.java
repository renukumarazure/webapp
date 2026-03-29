package com.cloudx.webapp.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.InetAddress;
import java.net.UnknownHostException;

@Controller
public class WebAppController {

   @GetMapping("/")
   public String home(Model model, HttpServletRequest request) throws UnknownHostException {
      InetAddress localHost = InetAddress.getLocalHost();

      model.addAttribute("hostname", localHost.getHostName());
      model.addAttribute("ip", localHost.getHostAddress());
      model.addAttribute("url", request.getRequestURL().toString());
      model.addAttribute("javaVersion", System.getProperty("java.version"));
      model.addAttribute("os", System.getProperty("os.name") + " " + System.getProperty("os.version"));

      return "home";
   }
}