---
title: "Diksha AI-Powered Multilingual College Chatbot Backend"
emoji: "🤖"
colorFrom: blue
colorTo: indigo
sdk: docker
pinned: false
---

# 🤖 Diksha - AI-Powered Multilingual College Chatbot

> An AI-powered multilingual college assistant for **GBPIET, Pauri Garhwal**, designed to answer student queries using a hybrid Retrieval-Augmented Generation (RAG) pipeline.

<div align="center">

![Python](https://img.shields.io/badge/Python-3.11+-3776AB?style=for-the-badge\&logo=python\&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-Backend-009688?style=for-the-badge\&logo=fastapi\&logoColor=white)
![RAG](https://img.shields.io/badge/AI-Hybrid%20RAG-purple?style=for-the-badge)
![Qdrant](https://img.shields.io/badge/Vector%20Search-Qdrant-red?style=for-the-badge)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge\&logo=postgresql\&logoColor=white)

</div>

---

## 📌 Overview

**Diksha** is an AI-powered multilingual chatbot built to help students access information about **GB Pant Institute of Engineering and Technology (GBPIET), Pauri Garhwal**.

The chatbot is designed to answer questions related to topics such as:

* Admissions
* Fees
* Courses
* Hostels
* Placements
* College administration
* Campus information
* Student life and other college-related queries

The backend exposes REST APIs built with **FastAPI** and combines language detection, conversation memory, hybrid retrieval, vector search, lexical search, reranking, and LLM-based answer generation.

The frontend is maintained separately and communicates with this backend through the API.

---

# ✨ Key Features

### 🌐 Multilingual Support

The chatbot supports:

* 🇬🇧 English
* 🇮🇳 Hindi
* 🏔️ Garhwali
* 🏔️ Kumauni

Language can be provided explicitly by the client or detected automatically from the user's query.

---

### 🧠 Hybrid Retrieval

The backend combines multiple retrieval techniques to improve answer relevance.

The retrieval pipeline includes components for:

* BM25 lexical search
* Vector similarity search
* Qdrant vector database
* Hybrid retrieval
* Reciprocal Rank Fusion (RRF)
* Reranking

---

### 💬 Conversation Memory

The backend maintains conversation context using a dedicated memory layer.

Each chat session is identified using a unique `session_id`, allowing the chatbot to use previous conversation context when generating responses.

Persistent storage is supported through:

* PostgreSQL when `DATABASE_URL` is configured for PostgreSQL
* SQLite fallback for environments where PostgreSQL is not configured

---

### 🤖 LLM-Based Answer Generation

The system integrates LLM providers through dedicated RAG modules.

The backend supports:

* Groq-based LLM integration
* Fallback model handling
* Optional Gemini integration when configured

The retrieval pipeline provides relevant context to the language model before generating the final answer.

---

### 🔍 Knowledge Base and Retrieval

The chatbot uses a structured knowledge base stored in the repository's `data/` directory.

The backend includes utilities for:

* Loading the QA knowledge base
* Building BM25 indexes
* Creating and querying embeddings
* Connecting to Qdrant
* Rebuilding the knowledge base

---

### 🌐 Website Scraping

The project includes a scraper and scheduler module for collecting and updating college website information.

The backend can:

* Run scraping jobs
* Check scrape status
* Schedule scraping operations
* Update website-related retrieval data

---

### 🔊 Text-to-Speech

The backend provides a Text-to-Speech API that generates audio for chatbot responses.

Audio is returned to the client in Base64 format.

---

### 📊 Evaluation

The repository includes evaluation functionality for testing chatbot behavior, including:

* Language detection
* In-scope and out-of-scope query detection
* Basic answer quality checks

---

# 🏗️ High-Level Architecture

```text
                        ┌───────────────────┐
                        │       User        │
                        └─────────┬─────────┘
                                  │
                                  ▼
                        ┌───────────────────┐
                        │    React Client   │
                        │  (Separate Repo)  │
                        └─────────┬─────────┘
                                  │
                                  ▼
                        ┌───────────────────┐
                        │   FastAPI API     │
                        │      /chat        │
                        └─────────┬─────────┘
                                  │
                    ┌─────────────┴─────────────┐
                    ▼                           ▼
          ┌──────────────────┐       ┌──────────────────┐
          │ Language Handling│       │ Conversation     │
          │ + Detection      │       │ Memory           │
          └────────┬─────────┘       └────────┬─────────┘
                   │                          │
                   └────────────┬─────────────┘
                                ▼
                    ┌─────────────────────┐
                    │   RAG Pipeline      │
                    └──────────┬──────────┘
                               │
              ┌────────────────┼────────────────┐
              ▼                ▼                ▼
          ┌─────────┐      ┌─────────┐      ┌──────────┐
          │  BM25   │      │ Vector  │      │ Knowledge│
          │ Search  │      │ Search  │      │   Base   │
          └────┬────┘      │ Qdrant  │      └──────────┘
               │           └────┬────┘
               └────────┬───────┘
                        ▼
              ┌───────────────────┐
              │ Hybrid Retrieval  │
              │ + Fusion          │
              │ + Reranking       │
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │   LLM Provider    │
              │ Groq / Optional   │
              │ Gemini Integration│
              └─────────┬─────────┘
                        ▼
              ┌───────────────────┐
              │ Final Response    │
              └───────────────────┘
```

---

# 🔄 Chat Request Flow

```text
User Question
      │
      ▼
POST /chat
      │
      ▼
Resolve Language
      │
      ├── Section selected by frontend
      ├── Explicit language provided
      └── Automatic language detection
      │
      ▼
Load Conversation Memory
      │
      ▼
Store User Message
      │
      ▼
Retrieve Relevant Information
      │
      ├── BM25 Search
      ├── Vector Search
      └── Hybrid Retrieval
      │
      ▼
Fusion + Reranking
      │
      ▼
LLM Answer Generation
      │
      ▼
Store Bot Response
      │
      ▼
Return Answer + Language + Session ID
```

---

# 📁 Project Structure

```text
college-chatbot-backend/
│
├── data/                     # College knowledge base and FAQ data
│
├── memory/                   # Conversation memory and database management
│   ├── database.py
│   └── memory_manager.py
│
├── rag/                      # Retrieval-Augmented Generation pipeline
│   ├── bm25_search.py
│   ├── embeddings.py
│   ├── fusion.py
│   ├── groq_manager.py
│   ├── hybrid_search.py
│   ├── internet_search.py
│   ├── kb_query.py
│   └── reranker.py
│
├── scraper/                  # Website scraping and scheduling
│
├── main.py                   # FastAPI application entry point
│
├── language_detector.py      # Language detection
├── intent_detector.py        # Query intent detection
│
├── qdrant_setup.py           # Qdrant configuration and setup
│
├── build_kb.py               # Knowledge base building utility
├── evaluate_chatbot.py       # Chatbot evaluation utility
├── run_scrape.py             # Scraping utility
│
├── voice.py                  # Text-to-Speech functionality
│
├── requirements.txt          # Python dependencies
├── Dockerfile                # Docker deployment configuration
├── Procfile                  # Process configuration
├── nixpacks.toml             # Deployment configuration
│
└── README.md
```

---

# 🛠️ Tech Stack

| Layer                    | Technology                   |
| ------------------------ | ---------------------------- |
| Backend Framework        | FastAPI                      |
| API Server               | Uvicorn                      |
| Language                 | Python                       |
| Validation               | Pydantic                     |
| Retrieval                | Hybrid Retrieval             |
| Lexical Search           | BM25                         |
| Vector Database          | Qdrant                       |
| Embeddings               | Sentence Transformers        |
| Reranking                | Dedicated reranker module    |
| LLM Integration          | Groq                         |
| Optional LLM Integration | Gemini                       |
| Conversation Storage     | PostgreSQL                   |
| Development Fallback     | SQLite                       |
| Website Data             | Custom Scraper               |
| Scheduling               | Scraper Scheduler            |
| Voice Output             | Text-to-Speech               |
| Deployment               | Docker / Hugging Face Spaces |

---

# 🧠 RAG Pipeline

The chatbot does not rely only on an LLM to answer questions.

Instead, it follows a Retrieval-Augmented Generation approach.

### 1. Query Processing

The incoming question is processed to determine:

* User language
* Query intent
* Relevant context
* Previous conversation history

---

### 2. Lexical Retrieval

BM25 search is used to identify documents or FAQ entries that contain relevant terms.

This helps with:

* Exact keyword matches
* College-specific terminology
* Structured FAQ content

---

### 3. Vector Retrieval

Embeddings are used to perform semantic similarity search.

Relevant documents can be retrieved from the vector database even when the user's wording differs from the original knowledge base.

---

### 4. Hybrid Retrieval

Results from lexical and vector search are combined.

The repository includes modules for:

* Hybrid search
* Reciprocal Rank Fusion
* Reranking

The goal is to improve the relevance of retrieved context before sending it to the LLM.

---

### 5. Answer Generation

The retrieved context and user query are passed through the answer-generation pipeline.

LLM integrations are handled through the RAG layer.

---

# 💾 Data and Storage

The backend uses different storage components for different responsibilities.

### 📚 Knowledge Base

College information and FAQ data are maintained in the `data/` directory.

### 🔎 Vector Search

Qdrant is used for vector-based retrieval.

The application supports:

* Qdrant Cloud through environment configuration
* Local Qdrant configuration where applicable

### 💬 Conversation Memory

Conversation history is handled through the `memory/` module.

The application supports:

* PostgreSQL when a PostgreSQL `DATABASE_URL` is configured
* SQLite fallback when PostgreSQL is not configured

---

# 📡 API Endpoints

## `GET /`

Returns basic application information.

Example response:

```json
{
  "chatbot": "Diksha",
  "college": "GBPIET, Pauri Garhwal",
  "status": "running",
  "version": "2.0.0"
}
```

---

## `GET /health`

Checks whether the API is running.

---

## `POST /chat`

Send a question to the chatbot.

### Request

```json
{
  "question": "What are the hostel facilities?",
  "session_id": null,
  "language": "en",
  "section": "english"
}
```

### Response

```json
{
  "answer": "The college provides hostel facilities for students...",
  "language": "en",
  "session_id": "generated-session-id",
  "chatbot_name": "Diksha"
}
```

### Supported language codes

| Language | Code |
| -------- | ---- |
| English  | `en` |
| Hindi    | `hi` |
| Garhwali | `ga` |
| Kumauni  | `ku` |

---

## `POST /tts`

Generate audio from text.

### Request

```json
{
  "text": "Welcome to GBPIET.",
  "lang": "en"
}
```

### Response

```json
{
  "audio_base64": "..."
}
```

---

## `GET /scrape-status`

Returns the current scraping status.

---

> ⚠️ **Note:** Operational and administrative endpoints are intended for project maintenance and should be secured before exposing the application publicly in a production environment.

---

# ⚙️ Local Setup

## 1. Clone the Repository

```bash
git clone https://github.com/phartyaldiksha05-ux/college-chatbot-backend.git
cd college-chatbot-backend
```

---

## 2. Create a Virtual Environment

### Windows

```bash
python -m venv venv
venv\Scripts\activate
```

### macOS / Linux

```bash
python3 -m venv venv
source venv/bin/activate
```

---

## 3. Install Dependencies

```bash
pip install -r requirements.txt
```

---

# 🔐 Environment Variables

Create a `.env` file in the project root.

The exact services you configure depend on the features you want to enable.

Example:

```env
# LLM
GROQ_API_KEY=your_groq_api_key

# Optional additional Groq keys
GROQ_API_KEY_2=
GROQ_API_KEY_3=
GROQ_API_KEY_4=

# Optional Gemini integration
GEMINI_API_KEY=

# Optional web search
SERPAPI_KEY=

# Database
DATABASE_URL=

# Qdrant
QDRANT_URL=
QDRANT_API_KEY=

# Environment
ENVIRONMENT=development

# Server
PORT=7860
```

> ⚠️ Never commit your `.env` file or real API keys to GitHub.

---

# 🚀 Running the Application

Start the FastAPI server:

```bash
uvicorn main:app --host 0.0.0.0 --port 7860 --reload
```

Alternatively:

```bash
python main.py
```

Once running, FastAPI documentation should be available at:

```text
/docs
```

For example:

```text
http://localhost:7860/docs
```

---

# 🐳 Deployment

The repository includes Docker configuration and is configured for deployment as a Docker-based application.

The current backend deployment is hosted on **Hugging Face Spaces**.

The application uses port `7860` by default when no platform-specific `PORT` environment variable is provided.

---

# 🌐 Related Frontend Repository

The React frontend is maintained separately.

**Frontend Repository:**

https://github.com/phartyaldiksha05-ux/diksha-chat-frontend

The frontend communicates with this backend through the REST API.

---

# 📊 Evaluation

The project includes chatbot evaluation functionality for checking:

### Language Detection

Tests language detection across:

* English
* Hindi
* Garhwali
* Kumauni

### Scope Detection

Tests whether the chatbot can distinguish between:

* GBPIET-related questions
* Out-of-scope questions

### Basic Answer Quality

Tests generated answers using expected keyword checks.

The repository also includes:

```text
evaluate_chatbot.py
```

for chatbot evaluation workflows.

---

# 🧪 Example Questions

### English

```text
What are the fees for BTech?
```

```text
Who is the director of GBPIET?
```

```text
Tell me about hostel facilities.
```

### Hindi

```text
जीबीपीआईईटी की फीस कितनी है?
```

```text
हॉस्टल की सुविधाएं क्या हैं?
```

### Garhwali

```text
फीस कति छ?
```

### Kumauni

```text
एडमिशन कसि होंछ?
```

---

# 🔄 Knowledge Base Updates

The repository includes utilities for maintaining the knowledge base.

Relevant files include:

```text
build_kb.py
run_scrape.py
qdrant_setup.py
```

The application can also initialize retrieval components during startup, including:

* BM25 indexing
* QA database loading
* Qdrant connectivity
* Scraper scheduling

---

# 🎯 Design Goals

The project was built with the following goals:

* Provide students with quick access to college information
* Support regional and multilingual communication
* Reduce dependence on manual FAQ searching
* Improve answer quality using retrieval instead of relying only on LLM generation
* Maintain conversation context
* Keep the frontend and backend independently deployable

---

# ⚠️ Current Limitations

This project is actively evolving.

Current areas for improvement include:

* Further modularization of API routes and orchestration logic
* Stronger authentication for administrative operations
* More comprehensive automated tests
* More formal RAG evaluation metrics
* Improved production monitoring and structured logging
* Better access control for operational endpoints

---

# 🔮 Future Improvements

Potential future improvements include:

* Streaming chatbot responses
* Improved RAG evaluation metrics
* Automated regression testing
* Role-based admin access
* Better API rate limiting
* Improved monitoring and observability
* Retrieval source citations in responses
* More structured analytics
* Expanded knowledge base coverage

---

# 👥 Project Team

* **Diksha Phartyal**
* **Anjali Gusain**
* **Suraj Singh Bisht**
* **Priyanshu Dhyani**

### Project Supervisor

**Mr. Kunwar Deep Narayan**

---

# 📄 License

This project was developed as an academic and research project.

Please contact the project contributors for reuse or collaboration-related questions.

---

# ⭐ Acknowledgements

This project was developed as part of an effort to make institutional information more accessible through AI and multilingual conversational interfaces.

Special focus was placed on:

* Multilingual accessibility
* Retrieval-Augmented Generation
* Regional language support
* College-specific knowledge retrieval
* Conversational user experience
