# ps-rule-azure

This image contains PowerShell with the PSRule, and  modules installed.

## Included components

The following components are included in the image.

- PowerShell Core, including the following PowerShell modules:
  - PSRule.Rules.Azure
  - PSRule
  - Az.Accounts
  - Az.Resources
  - Az.Security

## Using image

From Docker CLI:

```bash
docker pull docker.pkg.github.com/berniewhite/images/ps-rule-azure:<tag>
```

From Dockerfile:

```Dockerfile
FROM docker.pkg.github.com/berniewhite/images/ps-rule-azure:<tag>
```

## Featured tags

Tag           | Platform
---           | --------
latest-alpine | Alpine 3.8
v0-alpine     | Alpine 3.8
v0.4-alpine   | Alpine 3.8
latest-ubuntu | Ubuntu 18.04
v0-ubuntu     | Ubuntu 18.04
v0.4-ubuntu   | Ubuntu 18.04

For a complete list of image tags [see][ps-rule-azure-tags].

[ps-rule-azure-tags]: https://github.com/BernieWhite/images/packages/35463/versions
