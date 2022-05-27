docker build -f Dockerfile.base . -t dockerpilot:base $@
docker build -f Dockerfile.stage2 . -t dockerpilot:stage2 $@
docker build -f Dockerfile.stage3 . -t dockerpilot:stage3 $@
docker build -f Dockerfile.build . -t dockerpilot:latest $@
