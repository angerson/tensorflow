scoop bucket add versions
scoop bucket add extras
scoop install -g 7zip git openssh python nssm bazel versions/python27 msys2 jq

Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/buildkite/agent/master/install.ps1'))
nssm.exe install buildkite-agent "C:\buildkite-agent\bin\buildkite-agent.exe" "start"
nssm.exe set buildkite-agent AppStdout "C:\buildkite-agent\buildkite-agent.log"
nssm.exe set buildkite-agent AppStderr "C:\buildkite-agent\buildkite-agent.log"
