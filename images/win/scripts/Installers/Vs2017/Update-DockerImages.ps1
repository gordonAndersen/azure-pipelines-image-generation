################################################################################
##  File:  Update-DockerImages.ps1
##  Team:  ReleaseManagement
##  Desc:  Pull some standard docker images.
##         Must be run after docker is installed.
################################################################################

function DockerPull {
    Param ([string]$image)

    Write-Host Installing $image ...
    docker pull $image

    if (!$?) {
      echo "Docker pull failed with a non-zero exit code"
      exit 1
    }
}

DockerPull mcr.microsoft.com/windows/servercore:ltsc2016
DockerPull mcr.microsoft.com/windows/nanoserver:1803
DockerPull microsoft/aspnetcore-build:1.0-2.0
DockerPull mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2016
DockerPull mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2016

# Adding description of the software to Markdown

$SoftwareName = "Docker images"

$Description = @"
The following container images have been cached:
"@

Add-SoftwareDetailsToMarkdown -SoftwareName $SoftwareName -DescriptionMarkdown $Description

Add-ContentToMarkdown -Content $(docker images --digests --format "* {{.Repository}}:{{.Tag}} (Digest: {{.Digest}})")