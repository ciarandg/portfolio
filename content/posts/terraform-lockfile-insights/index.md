---
title: "Terraform Lockfile Insights"
date: 2024-02-18
draft: false
tags: ["go", "golang", "terraform", "tree-sitter"]
gallery: true
downloads: ['[Source Code](https://github.com/ciarandg/terraform-lockfile-insights)']
---

`terraform-lockfile-insights` is a utility designed to surface information about the Terraform providers used within a project. It recursively crawls a specified directory, parsing each Terraform lockfile using `tree-sitter`, and provides a report showing which providers and versions are used in each file.

Building this tool helped me get hands-on experience with both Golang and `tree-sitter`. I often work with repositories containing numerous Terraform modules, where managing provider versions and keeping the dependency scope small is crucial. Since `terraform-lockfile-insights` outputs its findings as JSON to `stdout`, it's well-suited for CI environments where teams might want to enforce policies around consistent provider versioning across a repository.

Example output (using `--pretty`):
```json
{
  "registry.opentofu.org/cloudflare/cloudflare": {
    "versions": {
      "4.19.0": [
        "infrastructure/terraform/foo/.terraform.lock.hcl",
        "infrastructure/terraform/bar/.terraform.lock.hcl",
        "infrastructure/terraform/baz/.terraform.lock.hcl"
      ]
    }
  }
}
```
