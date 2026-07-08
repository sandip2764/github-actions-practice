FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r assignment10/requirements.txt

COPY . .

CMD [ "python", "./script.py" ]
