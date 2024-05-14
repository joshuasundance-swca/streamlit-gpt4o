FROM python:3.11-slim-bookworm

RUN adduser --uid 1000 --disabled-password --gecos '' appuser
USER 1000

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH="/home/appuser/.local/bin:$PATH"

RUN pip install --user --no-cache-dir --upgrade pip

COPY ./requirements.txt /home/appuser/requirements.txt
RUN pip install --user --no-cache-dir  --upgrade -r /home/appuser/requirements.txt

COPY ./streamlit-gpt4o/ /home/appuser/streamlit-gpt4o/

WORKDIR /home/appuser/streamlit-gpt4o

CMD ["streamlit", "run", "/home/appuser/streamlit-gpt4o/app.py", "--server.port", "7860", "--server.address", "0.0.0.0"]
