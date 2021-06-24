# Use Alpine as base
FROM alpine:3.9

# Maintainer
MAINTAINER andreas@lacework.net

# Install python and pip
RUN apk add --update py2-pip

# Upgrade pip
RUN pip install --upgrade pip

# Install Python modules needed by the Python app
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Copy files required for the app to run
COPY app.py /usr/src/app/
COPY templates/index_template.html /usr/src/app/templates/index_template.html
COPY *.txt /usr/src/app/
RUN ls -la /usr/src/app/
RUN sed "s/<OUTPUT>/$(cat \/usr\/src\/app\/output.txt)/g" /usr/src/app/templates/index_template.html
# Expose the app on Flask default (5000)
EXPOSE 5000

# Run as non-root user
#RUN addgroup -g 10001 andreas && \
#    adduser -D -u 10001 -G andreas andreas
#USER andreas

# Healthcheck intstructions
# HEALTHCHECK CMD curl --fail http://localhost:5000/ || exit 1

# Run the application
CMD ["python", "/usr/src/app/app.py"]
