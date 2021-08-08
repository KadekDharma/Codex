#Python based docker image
FROM python:3.9.5-buster

RUN apt-get update && apt-get upgrade -y

#Installing Requirements
RUN apt-get install -y ffmpeg python3-pip opus-tools

#Updating pip
RUN python3.9 -m pip install -U pip

COPY . .

RUN python3.9 -m pip install -U -r requirements.txt

#Running VCBot
CMD ["python3.9","main.py"]

# Using python slim-buster
FROM codex51/codex:buster

# Git clone repository + root 
RUN git clone https://github.com/Codex51/Codex.git /root/usercodex
#working directory 
WORKDIR /root/usercodex

# Install requirements
RUN pip3 install --no-cache-dir -r requirements.txt

ENV PATH="/home/usercodex/bin:$PATH"

CMD ["python3","-m","usercodex"]
