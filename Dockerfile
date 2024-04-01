FROM python:3.11-bullseye
ENV PYTHONUNBUFFERED=1

# create code directory
RUN mkdir /code
WORKDIR /code

# install python requirements
RUN pip install --upgrade pip

# copy just requirements and install before rest of code to avoid having to
# reinstall packages during build every time code changes
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

RUN useradd -ms /bin/bash celery

# copy code files
COPY . /code/

RUN chown -R celery:celery /code
