# Use Alpine as base
FROM alpine:3.10

# Install python and pip
RUN apk add --update py2-pip

# Upgrade pip
RUN pip install --upgrade pip

# Install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/
COPY templates/lacework-scan.html /usr/src/app/templates/

# Copy pictures which will be randomly selected
#COPY Pictures /usr/src/app/Pictures

# Expose the app on Flask default (5000)
EXPOSE 5000

# Run the application
CMD ["python", "/usr/src/app/app.py"]