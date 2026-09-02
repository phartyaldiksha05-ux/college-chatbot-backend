 Diksha — AI-Powered Multilingual College Chatbot Backend

Backend service for **Diksha**, an AI-powered multilingual college chatbot designed to help students access institute-related information through a conversational interface.

The backend handles chatbot queries, knowledge retrieval, AI-powered response generation, multilingual processing, memory, evaluation, and supporting services.

---

## 🎯 Project Overview

Students often need to search through multiple websites, notices, documents, and departments to find college-related information.

Diksha provides a conversational interface where students can ask questions related to topics such as:

- Admissions
- Fees
- Hostels
- Courses
- Placements
- Contact information
- Other institute-related queries

The backend is designed to retrieve relevant information from the knowledge base and generate helpful responses for users.

---

## 🧠 Key Capabilities

- 🤖 AI-powered conversational responses
- 🌐 Multilingual query handling
- 🔎 Hybrid knowledge retrieval
- 📚 Knowledge-base search
- 🔤 BM25 lexical search
- 🧩 Vector-based semantic retrieval
- 🔀 Retrieval fusion
- 🎯 Reranking
- 🧠 Conversation memory
- 🔄 Fallback strategies
- 🤖 LLM-based response generation
- 🌐 Optional internet search capabilities
- 🔊 Text-to-speech support
- 📊 Chatbot evaluation utilities
- 🗄️ Database and vector-store integration
- ⚡ REST API built with FastAPI

---

# 🏗️ System Architecture

The chatbot follows a retrieval-based AI architecture.

```text
                    ┌──────────────┐
                    │     User     │
                    └──────┬───────┘
                           │
                           ▼
                    ┌──────────────┐
                    │ React Frontend│
                    └──────┬───────┘
                           │
                           │ API Request
                           ▼
                    ┌──────────────┐
                    │   FastAPI    │
                    │   Backend    │
                    └──────┬───────┘
                           │
                           ▼
                 ┌────────────────────┐
                 │ Query Processing   │
                 │ & Language Handling│
                 └─────────┬──────────┘
                           │
                           ▼
              ┌─────────────────────────┐
              │    Retrieval Pipeline   │
              └────────────┬────────────┘
                           │
          ┌────────────────┼────────────────┐
          ▼                ▼                ▼
       BM25 Search    Vector Search     Memory
          │                │                │
          └────────────────┼────────────────┘
                           │
                           ▼
                    Hybrid Retrieval
                           │
                           ▼
                    Fusion / RRF
                           │
                           ▼
                       Reranking
                           │
                           ▼
                 Relevant Context
                           │
                           ▼
                    LLM Generation
                           │
                           ▼
                    Final Response
                           │
                           ▼
                         User
🔎 Retrieval Pipeline

The chatbot does not rely only on an LLM to answer user questions.

A retrieval pipeline is used to find relevant information before generating a response.

The general flow is:

User Query
    │
    ▼
Query Processing
    │
    ▼
BM25 Search + Vector Search
    │
    ▼
Hybrid Retrieval
    │
    ▼
Result Fusion
    │
    ▼
Reranking
    │
    ▼
Relevant Context
    │
    ▼
LLM Response Generation
    │
    ▼
Final Answer

This approach helps ground responses in the available knowledge base instead of relying only on generative AI output.

🛠️ Technology Stack
Backend Framework
FastAPI
Uvicorn
AI and Language Processing
Groq API
Large Language Models
Sentence Embeddings
Retrieval
BM25
Vector Search
Hybrid Search
Reciprocal Rank Fusion (RRF)
Reranking
Data and Storage
Vector database integration
Knowledge base / FAQ data
Database support
Additional Features
Multilingual query processing
Conversation memory
Internet search integration
Text-to-Speech
Evaluation utilities
Scraping and knowledge-base update utilities
📂 Project Structure
college-chatbot-backend/
│
├── main.py
│
├── rag/
│   ├── bm25_search.py
│   ├── embeddings.py
│   ├── fusion.py
│   ├── groq_manager.py
│   ├── hybrid_search.py
│   ├── internet_search.py
│   ├── kb_query.py
│   └── reranker.py
│
├── data/
│
├── memory/
│
├── scraper/
│
├── evaluation/
│
├── requirements.txt
│
├── .env.example
│
├── .gitignore
│
└── README.md

The exact project structure may evolve as the backend continues to be modularized and improved.

🚀 Getting Started
Prerequisites

Make sure you have:

Python 3.10 or later
pip
Git
Clone the Repository
git clone https://github.com/phartyaldiksha05-ux/college-chatbot-backend.git

Navigate to the project:

cd college-chatbot-backend
Create a Virtual Environment
Windows
python -m venv venv
venv\Scripts\activate
Linux / macOS
python -m venv venv
source venv/bin/activate
Install Dependencies
pip install -r requirements.txt
⚙️ Environment Configuration

Create a .env file in the root directory.

Example:

# LLM API
GROQ_API_KEY=your_api_key

# Optional AI provider
GEMINI_API_KEY=your_api_key

# Database / Vector Store
DATABASE_URL=your_database_url

# Application Configuration
ENVIRONMENT=development

⚠️ Do not commit your .env file or API keys to GitHub.

The .env file should be included in .gitignore.

▶️ Running the Backend

Start the FastAPI server:

uvicorn main:app --reload

The API will typically run at:

http://localhost:8000
📖 API Documentation

FastAPI automatically provides interactive API documentation.

After starting the server, open:

http://localhost:8000/docs

Alternative documentation:

http://localhost:8000/redoc
🔌 API Endpoints

The backend provides endpoints for chatbot interaction and supporting functionality.

Examples include:

POST /chat
GET  /health
POST /tts

Additional operational and development endpoints may be available depending on the deployment environment.

Endpoint organization and access controls are being improved as part of the ongoing backend development.

🌐 Multilingual Support

The chatbot is designed to support multilingual interactions.

The backend processes user queries and applies language-aware handling before retrieval and response generation.

The goal is to improve accessibility for users who may prefer interacting in languages other than English.

🧠 Conversation Memory

The backend includes memory-related functionality to support multi-turn conversations.

Conversation context can be used to improve responses when a user's current question depends on previous messages.

Memory is treated separately from the primary knowledge retrieval pipeline.

🤖 LLM Integration

The system uses LLM services for response generation.

The LLM is used after relevant information is retrieved from the knowledge base.

General flow:

User Question
      │
      ▼
Retrieve Relevant Context
      │
      ▼
Provide Context to LLM
      │
      ▼
Generate Response

The system may use fallback strategies when a provider or model is unavailable.

🔊 Text-to-Speech

The backend includes text-to-speech functionality to support voice-based interaction.

This feature can be used by the frontend to provide audio responses where required.

📊 Evaluation

The project includes utilities for evaluating chatbot performance.

Evaluation can help identify:

Incorrect responses
Weak retrieval results
Missing knowledge
Response quality issues
Areas for improvement

The goal is to continuously improve the chatbot based on testing and real usage.

🔄 Knowledge Base Management

The chatbot relies on a knowledge base containing institute-related information.

The knowledge base and retrieval index may need to be updated when:

New information becomes available
Existing information changes
New FAQs are added
Missing user queries are identified

Knowledge-base maintenance is an important part of keeping chatbot responses relevant.

🧪 Testing and Development

The project is actively being improved through:

Manual query testing
Retrieval testing
Response validation
Error analysis
Knowledge-base improvements
Evaluation utilities

Future improvements include adding more automated testing and evaluation workflows.

🛡️ Security

Sensitive information such as API keys and database credentials should never be committed to the repository.

Use environment variables for configuration.

Example:

.env

Ensure .env is included in .gitignore.

Before deployment, operational endpoints should be protected using appropriate authentication and access controls.

🚧 Current Development

This project is actively being improved.

Current areas of focus include:

Improving retrieval accuracy
Improving multilingual query handling
Improving response quality
Better handling of ambiguous queries
Improving evaluation workflows
Refactoring large modules
Improving API organization
Improving logging
Strengthening security for operational endpoints
Improving documentation
🗺️ Future Improvements

Planned improvements include:

Modular API route architecture
Improved authentication for administrative operations
Better production logging
Automated tests
CI/CD workflows
Improved error handling
Better environment-based configuration
Improved monitoring
User feedback collection
Analytics for understanding real user queries
Continued improvement based on real-world usage
🧠 Development Philosophy

This project was developed as an evolving system rather than a one-time demonstration.

The development process involved experimenting with different retrieval and response-generation approaches and improving the system based on observed limitations.

The project continues to evolve through:

Identifying real user needs
Testing chatbot behavior
Finding retrieval and response failures
Improving the knowledge pipeline
Evaluating changes
Iterating based on results

The goal is not only to generate an answer, but to improve how the system retrieves, validates, and delivers information to users.

👥 Team Project

Diksha was developed as a collaborative academic project.

The project involved contributions from multiple team members across research, development, and implementation.

My Role

I took a leading role in the project and contributed across both frontend and backend development.

My contributions included:

Leading and coordinating the overall project implementation
Complete backend development
Backend API development using FastAPI
Designing and implementing the chatbot processing pipeline
Knowledge base preparation and management
AI and LLM integration
Retrieval pipeline implementation
Working with embeddings and semantic search
Integrating chatbot responses with the frontend
Testing chatbot responses
Identifying retrieval and response issues
Improving the chatbot based on testing and usage
Deployment and integration support

This was a collaborative team project. While multiple team members contributed to the overall project, I was responsible for the complete backend development and also contributed to frontend development and overall project implementation.

👥 Project Team
Diksha Phartyal
Anjali Gusain
Suraj Singh Bisht
Priyanshu Dhyani
🔗 Related Repository
Frontend Repository

🔗 https://github.com/phartyaldiksha05-ux/diksha-chat-frontend

The frontend provides the chatbot user interface and communicates with this backend through API requests.

📌 Project Status

🟢 Active Development

The chatbot is currently deployed and used for real student interactions.

The project continues to be improved based on real-world usage, testing, and ongoing development.

📬 Contact

Diksha Phartyal

GitHub:
https://github.com/phartyaldiksha05-ux

LinkedIn:
https://www.linkedin.com/in/diksha-phartyal-818357354/
