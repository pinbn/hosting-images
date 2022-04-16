function myenv(value,def) {
    return $_ENV[value] ?? def . PHP_EOL;
}
