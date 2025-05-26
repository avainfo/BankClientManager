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


       PROCEDURE DIVISION.
           DISPLAY "How Many Client do you want to add? ".
           STOP RUN.