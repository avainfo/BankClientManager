000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. BankClientManager.
000300 AUTHOR. Antonin Do Souto.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT Clients-File ASSIGN TO "assets/clients.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS.
           SELECT Temp-File   ASSIGN TO "temp.dat"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FS2.

       DATA DIVISION.
       FILE SECTION.
       FD Clients-File.
       01 Client-Rec.
           05 Client-ID         PIC 9(5).
           05 Client-FirstName  PIC X(15).
           05 Client-LastName   PIC X(20).
           05 Client-Amount     PIC 9(17).

       FD Temp-File.
       01 Temp-Rec.
           05 TClient-ID         PIC 9(5).
           05 TClient-FirstName  PIC X(15).
           05 TClient-LastName   PIC X(20).
           05 TClient-Amount     PIC 9(17).

       WORKING-STORAGE SECTION.
       77 WS-FS             PIC XX.
       77 WS-FS2            PIC XX.
       77 CLI-INPUT-TEXT    PIC X(2).
       77 CLI-INPUT         PIC 9(2) VALUE 0.
       77 EOF-FLAG          PIC X    VALUE "N".
       77 Clients-Count     PIC 9(9) VALUE 0.
       77 WS-Choice         PIC 9.
       77 WS-Amount         PIC 9(17).
       77 WS-Target-ID      PIC 9(5).

       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM Count-Clients
           PERFORM Main-Menu
           STOP RUN.

       Count-Clients.
           MOVE "N" TO EOF-FLAG
           OPEN INPUT Clients-File
           PERFORM UNTIL EOF-FLAG = "Y"
               READ Clients-File
                   AT END MOVE "Y" TO EOF-FLAG
                   NOT AT END ADD 1 TO Clients-Count
               END-READ
           END-PERFORM
           CLOSE Clients-File.

       Main-Menu.
           DISPLAY "=== Menu ==="
           DISPLAY "1: Add Clients"
           DISPLAY "2: Consult Client"
           DISPLAY "3: Deposit/Withdraw"
           DISPLAY "4: Display All"
           DISPLAY "0: Exit"
           DISPLAY "> " WITH NO ADVANCING
           ACCEPT CLI-INPUT-TEXT
           COMPUTE CLI-INPUT = FUNCTION NUMVAL(CLI-INPUT-TEXT)
           EVALUATE CLI-INPUT
               WHEN 1 PERFORM Add-Clients
               WHEN 2 PERFORM Consult-Client
               WHEN 3 PERFORM Transact-Client
               WHEN 4 PERFORM Display-Clients
               WHEN 0 DISPLAY "Exiting."
               WHEN OTHER DISPLAY "Invalid option."
           END-EVALUATE.

       Add-Clients.
           OPEN EXTEND Clients-File
           IF WS-FS = "35"
               OPEN OUTPUT Clients-File
           END-IF
           PERFORM VARYING WS-Target-ID FROM 1 BY 1
           UNTIL WS-Target-ID > CLI-INPUT
               MOVE WS-Target-ID TO Client-ID
               DISPLAY "Enter info for client #" WS-Target-ID
               DISPLAY " First name: " WITH NO ADVANCING
               ACCEPT Client-FirstName
               DISPLAY " Last name: " WITH NO ADVANCING
               ACCEPT Client-LastName
               DISPLAY " Amount: " WITH NO ADVANCING
               ACCEPT Client-Amount
               WRITE Client-Rec
               ADD 1 TO Clients-Count
           END-PERFORM
           CLOSE Clients-File.

       Consult-Client.
           MOVE "N" TO EOF-FLAG
           DISPLAY "Enter client ID to search: " WITH NO ADVANCING
           ACCEPT WS-Target-ID
           OPEN INPUT Clients-File
           PERFORM UNTIL EOF-FLAG = "Y"
               READ Clients-File
                   AT END MOVE "Y" TO EOF-FLAG
                   NOT AT END
                       IF Client-ID = WS-Target-ID
                           DISPLAY "Found: ID=" Client-ID ", Name="
                                   Client-FirstName " " Client-LastName
                                   ", Amount=" Client-Amount
                           MOVE "Y" TO EOF-FLAG
                       END-IF
               END-READ
           END-PERFORM
           CLOSE Clients-File.

       Transact-Client.
           PERFORM Consult-Client
           IF EOF-FLAG = "N"
               DISPLAY "1: Deposit  2: Withdraw  3: Cancel"
               WITH NO ADVANCING
               ACCEPT WS-Choice
               IF WS-Choice = 1 OR WS-Choice = 2
                   DISPLAY "Amount: " WITH NO ADVANCING
                   ACCEPT WS-Amount
                   IF WS-Choice = 1
                       ADD WS-Amount TO Client-Amount
                   ELSE
                       SUBTRACT WS-Amount FROM Client-Amount
                   END-IF
                   PERFORM Update-File
               ELSE
                   DISPLAY "Operation cancelled."
               END-IF
           ELSE
               DISPLAY "Client not found or operation cancelled."
           END-IF.

       Update-File.
           MOVE "N" TO EOF-FLAG
           OPEN INPUT Clients-File
           OPEN OUTPUT Temp-File
           PERFORM UNTIL EOF-FLAG = "Y"
               READ Clients-File
                   AT END MOVE "Y" TO EOF-FLAG
                   NOT AT END WRITE Temp-Rec FROM Client-Rec
               END-READ
           END-PERFORM
           CLOSE Clients-File
           CLOSE Temp-File
           DISPLAY "Update complete. Replace temp.dat by clients.dat".

       Display-Clients.
           MOVE "N" TO EOF-FLAG
           OPEN INPUT Clients-File
           PERFORM UNTIL EOF-FLAG = "Y"
               READ Clients-File
                   AT END MOVE "Y" TO EOF-FLAG
                   NOT AT END DISPLAY Client-ID ", " Client-FirstName
                   ", " Client-LastName ", " Client-Amount
               END-READ
           END-PERFORM
           CLOSE Clients-File.