# 💳 COBOL Mini Banking System

## 📝 Description
This is a personal project developed in **COBOL**, designed to simulate a basic banking client management system similar to those found in legacy batch-processing environments. It demonstrates how COBOL can still be effectively used for managing structured data and transactional workflows in critical systems.

The system allows for:
- Creating client records with an initial balance
- Searching for a client by ID
- Performing deposit or withdrawal operations
- Displaying the current account balance

## 🎯 Project Goals
This project highlights core COBOL concepts, including:
- Program structure (DIVISIONs)
- Reading and writing **sequential files**
- Structured data manipulation
- Conditional logic and control flow
- Terminal-based user interaction

## 📁 File Structure

| File                 | Purpose                                             |
|----------------------|------------------------------------------------------|
| `client.cbl`         | Main COBOL program                                   |
| `clients.dat`        | Sequential file containing client records            |
| `README.md`          | Project documentation                                |

### Format of `clients.dat`
```
<CLIENT_ID>|<LAST_NAME>|<FIRST_NAME>|<BALANCE>
Example: 1001|DURAND|PAUL|1250.75
```

## 🔧 Features
- **Add a client**: Input client data and write to file
- **Search client**: Find a client by ID and display their data
- **Banking operations**:
    - **Deposit**: Add amount to balance
    - **Withdraw**: Subtract amount with balance validation
- **Display balance**: Show current account balance

## ▶️ Execution

### Prerequisites:
- [GnuCOBOL](https://sourceforge.net/projects/open-cobol/) installed (`cobc`)

### Compilation:
```bash
cobc -x -o client client.cbl
```

### Run:
```bash
./client
```

## 🧠 About
This project was created to explore COBOL in the context of transactional data processing, inspired by legacy banking and financial systems still in production today. It showcases how COBOL remains relevant and effective in mission-critical environments.

## 👤 Author
**Antonin Do Souto**  
Fullstack developer specialized in critical systems and emerging technologies.  
[GitHub](https://github.com/avainfo) • [LinkedIn](https://www.linkedin.com/in/antonin-do-souto/)

---

## 🚀 Next Step
➡️ Migrate to an indexed file format (ISAM) or integrate with a mainframe simulator to move closer to enterprise-grade deployment.

## 📄 License
This project is open-source and released under the MIT License.
