
[CmdletBinding()]
param (
    [Parameter(Mandatory = $False)]
    [String]$Build = $Env:BUILD_BUILDNUMBER,

    [Parameter(Mandatory = $False)]
    [String]$BaseImage = $Env:BASEIMAGE,

    [Parameter(Mandatory = $True)]
    [String]$Image,

    [Parameter(Mandatory = $True)]
    [String]$Module,

    [Parameter(Mandatory = $False)]
    [String]$Configuration = 'Debug',

    [Parameter(Mandatory = $False)]
    [String]$Registry = $Env:REGISTRY
)

Write-Host -Object "[Pipeline] -- PWD: $PWD" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- Build: $Build" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- SourceBranch: $($Env:BUILD_SOURCEBRANCH)" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- SourceBranchName: $($Env:BUILD_SOURCEBRANCHNAME)" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- Commit: $($Env:BUILD_SOURCEVERSION)" -ForegroundColor Green;

if ($Env:SYSTEM_DEBUG -eq 'true') {
    $VerbosePreference = 'Continue';
}

Write-Host -Object "[Pipeline] -- Using Registry: $Registry" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- Using BaseImage: $BaseImage" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- Using Image: $Image" -ForegroundColor Green;
Write-Host -Object "[Pipeline] -- Using Module: $Module" -ForegroundColor Green;

# Synopsis: Install NuGet provider
task NuGet {
    if ($Null -eq (Get-PackageProvider -Name NuGet -ErrorAction Ignore)) {
        Install-PackageProvider -Name NuGet -Force -Scope CurrentUser;
    }
}

# Synopsis: Get the latest stable version
task GetLatest NuGet, {
    Install-Module -Name $Module -Repository PSGallery -Scope CurrentUser -Force;
}

# Synopsis: Get the latest pre-release version
task GetPrerelease NuGet, {
    Install-Module -Name $Module -Repository PSGallery -AllowPrerelease -Scope CurrentUser -Force;
}

task BuildImage GetLatest, {
    $versions = (Get-InstalledModule -Name $Module -AllVersions -ErrorAction Ignore);
    $stableVersion = @($versions | Where-Object -FilterScript {
        $_.Version -notlike "*-*"
    })[0].Version;
    $major = ([version]$stableVersion).Major
    $minor = ([version]$stableVersion).Minor
    # $latestVersion = @($versions | Where-Object -FilterScript {
    #     $_.Version -like "*-*"
    # })[0].Version;

    $dockerFile = "docker/$Image/stable/$BaseImage/docker/Dockerfile";
    $buildTag = "$($Image):stable-$BaseImage";
    $targetLatest = "$Registry/$($Image):latest-$BaseImage";
    $targetMajor = "$Registry/$($Image):v$major-$BaseImage";
    $targetMinor = "$Registry/$($Image):v$major.$minor-$BaseImage";

    exec {
        docker build -f $dockerFile -t $buildTag --build-arg VCS_REF=$Env:BUILD_SOURCEVERSION --build-arg MODULE_VERSION=$stableVersion .
    }

    exec {
        docker tag $buildTag $targetLatest
        docker tag $buildTag $targetMajor
        docker tag $buildTag $targetMinor
    }

    exec {
        docker push $targetLatest
        docker push $targetMajor
        docker push $targetMinor
    }
}

task . BuildImage
