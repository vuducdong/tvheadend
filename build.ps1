# Build tvhead_arm64_lite.tar on Windows (Docker Desktop with buildx). Run from the repo root.
param([string]$Out = "tvhead_arm64_lite.tar", [string]$Tag = "tvheadend-iptv-lite:latest")
$ErrorActionPreference = "Stop"
docker run --privileged --rm tonistiigi/binfmt --install arm64
docker buildx build --platform linux/arm64 -f Containerfile.iptv-lite --output "type=docker,dest=$Out" -t $Tag .
(Get-FileHash -Algorithm SHA256 $Out).Hash.ToLower() + "  " + $Out | Tee-Object "$Out.sha256"
Get-Item $Out | Select-Object Name, Length
