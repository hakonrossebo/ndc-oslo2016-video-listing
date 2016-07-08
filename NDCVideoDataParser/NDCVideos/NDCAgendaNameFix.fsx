module NDCAgendaNameFix
  let fixNameMismatch name = 
    match name with
    | "ASP.NET Core 1: What has changed for MVC and Web API developers? - Manfred Steyer" -> "ASP.NET 5: What has changed for MVC and Web API developers?"
    | "App 2.0 - why the web lost and Apps won - Liam Westley" -> "App 2.0 - why the web lost and Apps won."  
    | "Keynote NDC Oslo 2016: Yesterday’s Technology is Dead, Today’s is on Life Support - Troy Hunt" -> "Keynote: Yesterday’s Technology is Dead, Today’s is on Life Support"  
    | "Linux, Open Source and Microsoft Azure: unusual friends? - Boris Baryshnikov" -> " Linux, Open Source and Microsoft Azure: unusual friends?"  
    | "MicroMonolith - Top anti-patterns of distributed systems - Michal Franc" -> " × MicroMonolith - Top anti-patterns of distributed systems"  
    | "NDC Oslo 2016: sequential, concurrent and parallel programming" -> "Sequential, Concurrent and Parallel Programming"  
    | "Offline is the new black  - Max Stoiber" -> "Offline Web Applications"  
    | "There's treasure everywhere -  Andrei Alexandrescu" -> "Fastware"  
    | "Write once, run everywhere\" is not a myth - Mahesh Krishnan & Cristian Prieto" -> "\"Write once, run everywhere\" is not a myth\""  
    | "You Don't Know Node.js - Azat Mardan" -> "\"You Don't Know Node.js\""  
    | _ -> name



 

 
  

  
  

  
  

  
  
  
  
  

  
  
  
