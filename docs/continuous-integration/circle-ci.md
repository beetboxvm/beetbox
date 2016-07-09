# Continuous Integration

As beetbox uses Circle CI for continuous integration you are able to reuse this as the base for your own project.
The following circle.yml file will setup Circle CI to replicate your beetbox environment, then you can simply add your own tests.

You might also need to extend the dependencies to setup your project for tests to be run.

Whilst we use Circle CI the same concept could be applied to other CI providers.

- Create an account @ https://circleci.com/
- Add the `circle.yml` to the root of the project
- Link the repository with Circle CI.

## circle.yml

```
---
dependencies:
  override:
    - bash <(curl -fsSL http://bit.ly/beetbuild)
test:
  override:
    #- /path/to/tests.sh
```

# Deployment

Circle CI can be extended to automate deployments.

see https://circleci.com/docs/configuration#deployment
