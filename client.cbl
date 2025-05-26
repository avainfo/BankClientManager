000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. BankClientManager.
000300 AUTHOR. Antonin Do Souto.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Client.
           05 Client-ID PIC 9(5).
           05 Client-FirstName PIC X(15).
           05 Client-LastName PIC X(20).
           05 Client-Amount PIC 9(17).
       01 Cli-input PIC 9(2).


       PROCEDURE DIVISION.
           DISPLAY "How Many Client do you want to add? (99 max)".
           display "> " WITH no ADVANCING.
           ACCEPT CLI-INPUT.
           perform until CLI-INPUT = 0
               perform CLIENT-INFOS
               SUBTRACT 1 from CLI-INPUT
           END-PERFORM
           STOP RUN.

       CLIENT-INFOS.
           display "Enter client information: ".
           display "First name: " with no ADVANCING.
           accept CLIENT-FIRSTNAME.
           display "Last name: " with no ADVANCING.
           accept CLIENT-LASTNAME.
           display "Amount of money: " with no ADVANCING.
           accept CLIENT-AMOUNT.