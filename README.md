Windows BOSH Release Example
============================
💡 _A quick primer on getting started building Windows BOSH releases_

## 🎬 Getting Started

Fork this repo as a starting point _or_ initialize your release and git repository with the expected release directory structure
```
bosh init-release --git
```

**NOTE**: This is intended to be used as a BOSH [addon](https://bosh.io/docs/runtime-config/#update)

## ⚙️ Create a BOSH runtime configuration
_Example runtime configuration YAML to run on a variety of Windows stemcells_

```yml
releases:
- name: windows-bosh-release-example
  version: 0.0.2-alpha

addons:
- name: windows-bosh-release-example
  jobs:
  - name: example
    release: windows-bosh-release-example
  include:
    stemcell:
    - os: windows2012R2
    - os: windows1803
    - os: windows2019
```

📣 See the [Platform Automation Documentation](https://docs.pivotal.io/platform-automation/v5.0/tasks.html#update-runtime-config) for help including this with Ops Manager deployed BOSH

## 🔨 Building an updated release
* Clone this repo and navigate to `windows-bosh-release-example/`
  ```console
  git clone git@github.com:conzetti/windows-bosh-release-example.git
  pushd windows-bosh-release-example/
  ```

* Print out the current ["blobs" ](https://bosh.io/docs/release-blobs/)
  ```console
  ➜  bosh blobs
  Path                            Size    Blobstore ID                          Digest
  msi/NessusAgent-10.3.0-x64.msi  71 MiB  7905ac5e-8d6d-478b-713f-727ce70abcfa  sha256:3b2867040555de86c636c57c6e90bf6a35cf3134f1e14f58bb821a9826e973a7

  1 blobs

  Succeeded
  ```

* Purge the current blob
  ```console
  bosh remove-blob msi/NessusAgent-10.3.1-x64.msi
  ```

* Gather the _latest_ Nessus agent from https://www.tenable.com/downloads/nessus-agents

* Add the updated agent to the BOSH blob store
  ```console
  bosh add-blob ~/Downloads/NessusAgent-10.3.1-x64.msi msi/NessusAgent-10.3.1-x64.msi
  ```

* Amend the following files with the updated agent version
  ```
  jobs/example/templates/pre-start.ps1
  packages/nessus/packaging
  packages/nessus/spec
  ```

- run the following command to build the release package
  ```bash
  bosh create-release \
    --name windows-bosh-release-example \
    --version <CURRENT_RELEASE> \
    --tarball /tmp/release.tgz \
    --[force | final]
  ```
* **NOTE**: When crafting your `runtime.yml`, be sure to reference the updated release version (_and_ make sure that you've uploaded the new release to BOSH)