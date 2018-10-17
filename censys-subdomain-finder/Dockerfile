  #
  # Censys Subdomain Finder
  #
  # Info: https://www.kitploit.com/2018/10/censys-subdomain-finder-perform.html?amp=0
  # Source: https://github.com/christophetd/censys-subdomain-finder.git
  #
  # Run with:
  # docker run --rm \
  # -e CENSYS_API_ID=<api-id> \
  # -e CENSYS_API_SECRET=<api_secret> \
  # sdaaish/censys_subdomain_finder <domain-name>
 
FROM jfloff/alpine-python:3.6-slim

COPY src/requirements.txt src/*.py /app/
WORKDIR /app

RUN pip install -r requirements.txt --no-cache-dir

ENTRYPOINT ["python", "./censys_subdomain_finder.py"]
CMD ["--help"]
