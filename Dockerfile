ARG VARIANT="16-buster"
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:${VARIANT}

RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - ; \
echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list

RUN apt-get update \
&& apt-get -y install --no-install-recommends cf7-cli sqlite

RUN su node -c "npm install -g @ui5/cli @sap/cds-dk yo"

## Download BTP Cli
RUN curl -LJO https://raw.githubusercontent.com/SAP-samples/sap-tech-bytes/2021-09-01-btp-cli/getbtpcli

## Set permission
RUN chmod +x getbtpcli

## Copy script and add a -y flag to accept by default
RUN echo -ne '\n' | ./getbtpcli

## Add BTP to Path
ENV PATH "$PATH:./root/bin/"