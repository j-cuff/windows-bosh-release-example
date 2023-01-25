Windows BOSH Release Example
============================
💡 _A quick primer on getting started building Windows BOSH releases_

## Getting Started

Fork this repo _or_ initialize your release and git repository with the expected release directory structure
```
bosh init-release --git
```

**NOTE**: This is intended to be used as a BOSH [addon](https://bosh.io/docs/runtime-config/#update)

## Example runtime configuration YAML

```yml
releases:
- name: windows-bosh-release-example
  version: 7

addons:
- name: windows-bosh-release-example
  jobs:
  - name: example
    release: windows-bosh-release-example
  include:
    stemcell:
    - os: windows2019
```

📣 See the [Platform Automation Documentation](https://docs.pivotal.io/platform-automation/v5.0/tasks.html#update-runtime-config) for help including this with Ops Manager deployed BOSH