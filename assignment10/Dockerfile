FROM python:3

WORKDIR /usr/src/app

COPY ./assignment10/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY ./assignment10/ .

CMD [ "python", "./script.py" ]
