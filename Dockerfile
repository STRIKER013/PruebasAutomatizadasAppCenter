FROM python:alpine3.18
WORKDIR /home
COPY ./requirements.txt /home/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /home/requirements.txt
COPY ./app /home/app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]