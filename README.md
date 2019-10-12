# Docker images

This project is a repository for public docker images.

## Disclaimer

This project is to be considered a **proof-of-concept** and **not a supported product**.

If you have any problems please check our GitHub [issues](https://github.com/BernieWhite/images/issues) page. If you do not see your problem captured, please file a new issue and follow the provided template.

## Images

Image name | Description
---------- | -----------
[psrule][ps-rule-info] | Validate objects using PowerShell rules

### Platforms

Images are built for the following platforms:

- Alpine
- Ubuntu

### Versioning

Images in this repository use the following labels:

- `:latest-<platform>`: The latest stable version. i.e. `:latest-alpine`
- `:v<major>-<platform>`: The last stable version of the `<major>` release. i.e. `:v1-alpine`
- `:v<major>.<minor>-<platform>`: The last stable version of the `<major>.<minor>` release. i.e. `:v1.1-alpine`

## Maintainers

- [Bernie White](https://github.com/BernieWhite)

## License

This project is [licensed under the MIT License](LICENSE).

[ps-rule-info]: docker/ps-rule/README.md
