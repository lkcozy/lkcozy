#!/usr/bin/env zx

// Define an array of Bilibili video URLs
const urls = [];

const options = ["--audio-only", "--skip-cover"];

async function downloadLatestBBDown() {
  const currentVersion = "1.6.1";
  const releaseUrl =
    "https://api.github.com/repos/nilaoda/BBDown/releases/latest";

  const result = await $`curl -s ${releaseUrl} | jq -r '.tag_name'`;
  const latestVersion = result.stdout.trim();
  if (currentVersion !== latestVersion) {
    console.log(
      "Found new version of BBDown: ",
      chalk.bgGreen.bold(latestVersion)
    );
    return;
  }

  const { stdout } =
    await $`curl -s ${releaseUrl} | jq '.assets[] | select(.name | contains("osx-x64")) | .browser_download_url'`;
  const url = stdout.trim().replace(/"/g, "");
  console.log("BBDown latest url:", chalk.bgGreen.bold(url));
  $`curl -Lk ${url} -o temp.zip && unzip -o temp.zip && chmod +x BBDOWN && rm temp.zip`;
}

async function downloadAudios() {
  urls.forEach((url, index) => {
    console.log(`[${index + 1}] Processing URL: ${chalk.bgGreen.bold(url)}`);
    $`./BBDown ${url} ${options} `;
  });
}

await downloadLatestBBDown();
await downloadAudios();
