# Contributing
These are some rules and guidelines when contributing to Apollo, please follow them. 

## Commit style
Apollo uses the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) format, as seen in the following:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

In particular, we primarily use the following types:
- ```feat```: adding a new major feature to Apollo
- ```fix```: fixing an issue in Apollo or the repository (e.g., ci workflows, mkosi configuration)
- ```chore```: component updates, refactors or other changes that can't otherwise be classed as a feat or fix
- ```docs```: adding documentation to the repositories, including .md files in the repo.

When choosing the scope to use, it's ultimately your discretion. As a general rule, profile-specific changes should use the profile name, ci/workflow changes should use `ci` and changes to the base config should use the most appropriate file name (e.g. extra). If appropriate, scope may be omitted entirely.

## Code of Conduct
Please make sure that your contribution, including communication around it, follows the [Apollo Code of Conduct](https://github.com/apollo-linux/.github/blob/main/CODE_OF_CONDUCT.md). This is currently the Contributor Covenant 3.0. 
