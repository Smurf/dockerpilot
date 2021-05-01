docker build -f Dockerfile.base -t openpilot:base
docker build -f Dockerfile.stage2 -t openpilot:stage2
docker build -f Dockerfile.build -t openpilot:latest
