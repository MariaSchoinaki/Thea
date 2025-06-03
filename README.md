# 🎭 Thea: NLP-Driven Theater Ticketing Application

**Watch the Demo Video** [here](https://youtu.be/mclSJEVypuQ?si=w-X5gPzh7WQq9Buu)

## Overview

**Thea** is a cross-platform mobile application designed to simplify theater ticket booking through a natural language interface.  
The chatbot enhances the user experience by providing essential information about shows, assisting with ticket bookings, and managing other requests in an intuitive and user-friendly manner.  
The app prioritizes accessibility for both tech-savvy and elderly users, integrating both manual menus and an NLP-powered chatbot for a seamless user experience.

---

## Key Features

- **Real-time Show Information:**  
  Instantly ask the chatbot for current performance details, including which hall a show is in and afternoon/evening schedules.

- **Conversational Ticket Booking:**  
  The chatbot walks users step-by-step through ticket reservations—choose your show, select seats, confirm, or cancel before finalizing.

- **Easy Ticket Cancellation:**  
  Cancel booked tickets quickly and intuitively via chatbot conversation, with confirmation to prevent mistakes.

- **Complaints and Feedback:**  
  Submit complaints or feedback directly through the chatbot. Issues can be escalated to a human agent for further assistance.

- **Accessibility Support:**  
  The app supports accessible seating (e.g., near interpreters for hearing-impaired users) and offers supertitles for certain shows to enhance the experience for everyone.

- **Manual & Guided Actions:**  
  Traditional menu navigation is available alongside the NLP-powered chatbot, making the app friendly for both tech-savvy and less experienced users.

- **Robust Error Handling:**  
  Confirmation dialogs prevent unwanted actions. After repeated misunderstandings, the system can seamlessly escalate to a human agent.

- **Support for Elderly and Inclusive Design:**  
  Large buttons, readable fonts, simple navigation, and optional voice interaction ensure the app is usable by people of all ages and abilities.

- **Multi-Stage Booking & Management:**  
  Supports viewing plays, selecting dates/times, choosing seats, making payments, and managing your tickets all in one place.

- **Intelligent Backend:**  
  LLM-based chatbot (LLaMA 3.2), RAG pipeline (LangChain + FAISS), and a secure Flask API power the conversational and ticketing logic.

---

## Tech Stack

- **Flutter (Dart):**  
  Modern, cross-platform framework for building beautiful, responsive mobile apps, ensuring seamless performance and a consistent user experience on both iOS and Android devices.

- **Flask (Python):**  
  Lightweight, high-performance backend framework that handles API requests, ticket management, and serves as the bridge between the mobile frontend and AI-driven chatbot services.

- **Large Language Model (LLM):**  
  Advanced NLP technology (LLaMA 3.2) powers the chatbot, enabling accurate understanding of user intent, natural conversations, and intelligent assistance throughout the app.

- **Retrieval-Augmented Generation (RAG):**  
  Integrates with LangChain and FAISS to empower the chatbot with real-time access to theater information and context-aware responses, delivering up-to-date answers based on backend data.

- **FAISS:**  
  High-speed vector database for efficient retrieval of relevant information, ensuring the chatbot delivers accurate, context-rich answers to user queries.

- **LangChain:**  
  Orchestrates the conversation flow and connects the LLM with the backend, enabling flexible, robust, and reliable information retrieval in real time.

---

### Why This Stack?

This tech stack enables **scalability**, **real-time performance**, and a **premium user experience**. Leveraging the latest advancements in mobile development and conversational AI, Thea delivers an innovative, accessible, and reliable solution for theater-goers of all ages.


## System Architecture

- **Frontend:** Mobile app built according to HCI best practices (Figma/Android Studio)
- **Backend:**  
  - Flask API for ticketing logic  
  - LLM chatbot (LLaMA 3.2)  
  - LangChain & FAISS for Retrieval-Augmented Generation (RAG)  
- **Chatbot:**  
  - Understands free-form requests  
  - Error handling and escalation  
  - Complaint submission flow  
  - Integrated fallback to human support

---

## Prototypes

See [Paper Prototypes](https://drive.google.com/drive/folders/1xF2_Uc2FPMEayIRCFTd0w7BhIxO7R4Cd?usp=sharing) and [Figma Prototypes](https://drive.google.com/drive/folders/1I4XQjdXnCj3sGRjnRG6HTxPwFPO5AsO7?usp=sharing).

---

## 📁 Installation & Usage

1. **Clone this repo:**
   ```bash
   git clone https://github.com/MariaSchoinaki/Thea.git
   cd Thea

2. **Navigate to the AI script directory:**
   ```bash
   cd theater-chatbot/lib/ai_script
   ```

3. **Start the AI server:**
   - Open the `llama_chat_with_rag_faiss.ipynb` notebook.
   - Run all cells to instantiate the server.

4. **Launch the mobile app:**
   - Connect your mobile phone to your development environment, or use an emulator.
   - From the project root directory, run:
     ```bash
     flutter run
     ```
## Contributors
- **Developer:** [Maria Schoinaki](https://github.com/MariaSchoinaki)
- **Developer:** [Eleni Kechrioti](https://github.com/EleniKechrioti)
- **Developer:** [Giorgos Isoufai](https://github.com/giwrgosisf)