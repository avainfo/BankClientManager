000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. BankClientManager.
000300 AUTHOR. Antonin Do Souto.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT Clients-File ASSIGN TO "clients.dat"
               ORGANIZATION is line SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD Clients-File.
       01 Client.
           05 Client-ID PIC 9(5).
           05 Client-FirstName PIC X(15).
           05 Client-LastName PIC X(20).
           05 Client-Amount PIC 9(17).

       WORKING-STORAGE SECTION.
       01 Cli-input PIC 9(2).
       01 EOF PIC X VALUE "N".
       01 Temp-Rand PIC 9(4).
       01 Clients-COUNT PIC 9(9).


       PROCEDURE DIVISION.
           perform INTRO
           perform COUNT-CLIENTS

           perform until CLI-INPUT = 0
               perform CLIENT-INFOS
               SUBTRACT 1 from CLI-INPUT
           END-PERFORM
           STOP RUN.

       INTRO.
           DISPLAY "How Many Client do you want to add? (99 max)".
           display "> " WITH no ADVANCING.
           ACCEPT CLI-INPUT.

       CLIENT-INFOS.
           
           OPEN EXTEND Clients-File
           display "Enter client information: ".
           display "First name: " with no ADVANCING.
           accept CLIENT-FIRSTNAME.
           display "Last name: " with no ADVANCING.
           accept CLIENT-LASTNAME.
           display "Amount of money: " with no ADVANCING.
           accept CLIENT-AMOUNT.
           ADD 1 to CLIENTS-COUNT
           move CLIENTS-COUNT to CLIENT-ID
           WRITE Client.
           CLOSE CLIENTs-FILE.

       COUNT-CLIENTS.
           OPEN INPUT CLIENTS-FILE
               perform until EOF = "Y"
                   read CLIENTS-FILE
                       at END
                           MOVE "Y" to EOF
                       NOT AT END
                           ADD 1 TO CLIENTS-COUNT
                   END-READ
               END-PERFORM
           CLOSE CLIENTS-FILE.