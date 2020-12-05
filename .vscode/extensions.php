{
  // See https://go.microsoft.com/fwlink/?LinkId=827846 to learn about workspace recommendations.
  // Extension identifier format: ${publisher}.${name}. Example: vscode.csharp
  // List of extensions which should be recommended for users of this workspace.
  "recommendations": [
<?php

$stdin = fopen('php://stdin', 'r');

$extensions = [];
while ($line = trim(fgets($stdin))) {
  $extensions[] = $line;
}
fclose($stdin);
echo "    \"" . implode($extensions, "\",\n    \"") . "\"\n  ";
?>
  ],
  // List of extensions recommended by VS Code that should not be recommended for users of this workspace.
  "unwantedRecommendations": []
}
