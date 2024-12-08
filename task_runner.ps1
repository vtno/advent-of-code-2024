param (
    [Parameter(Position=0, Mandatory=$true)]
    [string]$Question,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$Mode
)

switch ($Mode) {
  "run" { & ".\bin\$Question.exe" }
  "debug" { crystal run .\src\$Question.cr }
  Default { crystal build --release --progress -o .\bin\$Question .\src\$Question.cr }
}
