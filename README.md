# CI/CD Practice Repository

We'll deploy a sample `httpd` server and integrate a CI/CD deployment pipeline, starting with GitHub Actions.


## httpd Notes

We will use [this](https://hub.docker.com/_/httpd) image because it's simpler than the official Apache2 image. 

- `docker run -p 8080:80 httpd:2.4-alpine` maps host port 8080 to container port 80
- `SIGWINCH` (SIGNAL WINDOW CHANGE) will stop the container, so take care - background with `&`
- The file being served on container port 80 is `/usr/local/apache2/htdocs/index.html`
- Config for the server is in `/usr/local/apache2/conf/httpd.conf`
    - `Listen 80`: listen on port 80 (inside the container)

Command-line mounting of this repo's `index.html` file into the container (run this the repo's working directory):

```sh
docker run -p 8080:80 --volume $(pwd)/html:/usr/local/apache2/htdocs httpd:2.4-alpine
```

(The command above is a runtime mount, so any changes while the container is running WILL show up when you refresh.)

## GitHub Actions

- When you pull the repository onto the runner with `actions/checkout@v4`, the working directory for the runner becomes the top-level directory of your repository, **minus** the `.github` folder.
- Secrets like credentials or access tokens can be stored as repository secrets, then referenced in workflows via `env` for any given step. As an example, for a step that authenticates to Docker:

```
    - name: Authenticate to Docker
      env:
        TOKEN: ${{ secrets.docker_token }}
      run: docker login -u forsakenidol -p $TOKEN
```

This requires that a secret be uploaded to the repository under the name `docker_token`.
