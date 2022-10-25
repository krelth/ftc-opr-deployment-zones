# OnePageRules Deployment Zones for FTC Map Base

[Get it on Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2878060900)

![](https://steamuserimages-a.akamaihd.net/ugc/1933758985523677836/C30358954B40358D58CD47AFA1916B2A7CEAEA03/?imw=5000&imh=5000&ima=fit&impolicy=Letterbox&imcolor=#000000&letterbox=false)

A Tabletop Simulator mod adding a UI for spawning [OnePageRules](https://onepagerules.com/)-style deployment zones.

Intended for use with [FTC Grimdark Future OPR Map Base](https://steamcommunity.com/sharedfiles/filedetails/?id=2732252928).

## Development

If you are on linux, make sure you have make and npm installed, then run `make build`.
The final json and thumbnail will be saved to `./dist`.
Running `make publish` will copy the files to your TTS save game directory.

If you use another operating system, install docker, then run:
```
docker build -t tts-ftc-opr-deployment-zones-builder .;
docker run -it  --volume ${PWD}/src:/build/src --volume ${PWD}/Makefile:/build/Makefile --volume ${PWD}/dist:/build/dist:rw tts-ftc-opr-deployment-zones-builder`
