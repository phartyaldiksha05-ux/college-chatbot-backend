FROM python:3.11-slim

WORKDIR /app

ENV HF_HOME=/app/.cache
ENV SENTENCE_TRANSFORMERS_HOME=/app/.cache
ENV TRANSFORMERS_CACHE=/app/.cache
ENV HF_HUB_DISABLE_PROGRESS_BARS=1

COPY requirements.txt .

RUN pip install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cpu
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 7860

CMD ["uvicorn","main:app","--host","0.0.0.0","--port","7860"]
