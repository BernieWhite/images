# escape=`

#
# PSRule
#

ARG fromTag=windowsservercore-1809
ARG imageRepo=mcr.microsoft.com/powershell
ARG VCS_REF="none"
ARG MODULE_VERSION=0.11.0

# Use PowerShell image
FROM ${imageRepo}:${fromTag}
SHELL ["pwsh", "-NoLogo", "-NoProfile", "-Command"]
RUN Install-Module -Name PSRule -RequiredVersion ${MODULE_VERSION} -Force;

CMD ["pwsh"]

# Add standard labels -- http://label-schema.org/
LABEL maintainer="Bernie White" `
    readme.md="https://github.com/Microsoft/PSRule/blob/master/README.md" `
    description="Validate objects using PowerShell rules." `
    org.label-schema.name="PSRule" `
    org.label-schema.url="https://microsoft.github.io/PSRule/" `
    org.label-schema.vcs-url="https://github.com/BernieWhite/images/" `
    org.label-schema.vcs-ref=${VCS_REF} `
    org.label-schema.vendor="Bernie White" `
    org.label-schema.version=${MODULE_VERSION} `
    org.label-schema.schema-version="1.0"
